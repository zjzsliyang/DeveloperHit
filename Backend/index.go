package main

import (
	"encoding/xml"
	"fmt"
	"log"
	"net/http"

	"github.com/zjzsliyang/go-trending"
)

type Developer struct {
	ID          int    `xml:"id"`
	DisplayName string `xml:"display_name"`
	FullName    string `xml:"full_name"`
	URL         string `xml:"url"`
	Avatar      string `xml:"avator"`
}

type Project struct {
	Name           string      `xml:"name"`
	Owner          string      `xml:"owner"`
	RepositoryName string      `xml:"repository_name"`
	Description    string      `xml:"description"`
	Language       string      `xml:"language"`
	Stars          int         `xml:"stars"`
	URL            string      `xml:"url"`
	ContributorURL string      `xml:"contributor_url"`
	Contributor    []Developer `xml:"developer"`
}

type Projects struct {
	XMLName xml.Name  `xml:"projects"`
	Version string    `xml:"version,attr"`
	XsiUrl  string    `xml:"xmlns:xsi,attr"`
	XmlUrl  string    `xml:"xsi:noNamespaceSchemaLocation,attr"`
	Project []Project `xml:"project"`
}

func Trend(res http.ResponseWriter, req *http.Request) {
	trend := trending.NewTrending()
	xsiUrl := "http://www.w3.org/2001/XMLSchema-instance"
	xmlUrl := "https://github.com/zjzsliyang/DeveloperHit/raw/master/Backend/github.xsd"

	projects, err := trend.GetProjects(trending.TimeToday, "")
	if err != nil {
		log.Fatal(err)
	}
	dataProjects := &Projects{Version: "1", XsiUrl: xsiUrl, XmlUrl: xmlUrl}
	for _, project := range projects {
		dataProject := Project{Name: project.Name, Owner: project.Owner, RepositoryName: project.RepositoryName,
			Description: project.Description, Language: project.Language, Stars: project.Stars, URL: project.URL.String(),
			ContributorURL: project.ContributorURL.String()}
		for _, contributor := range project.Contributor {
			dataDeveloper := Developer{ID: contributor.ID, DisplayName: contributor.DisplayName, FullName: contributor.FullName,
				URL: contributor.URL.String(), Avatar: contributor.Avatar.String()}
			dataProject.Contributor = append(dataProject.Contributor, dataDeveloper)
		}
		dataProjects.Project = append(dataProjects.Project, dataProject)
	}
	res.Write([]byte(xml.Header))
	output, err := xml.MarshalIndent(dataProjects, "  ", "    ")
	if err != nil {
		fmt.Println("err: %v", err)
	}
	res.Write(output)
}

func main() {
	http.HandleFunc("/github", Trend)
	http.ListenAndServe(":8000", nil)
}
