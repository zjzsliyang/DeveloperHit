# Programming with Web API Proposal

### *DeveloperHit*

After exploring some Web APIs associated with the chosen topic, only a few websites provide friendly APIs, especially when an XML format data response is expected. Therefore we decided to build our own APIs by parsing HTML pages responded from target websites:

- Github

  Github trending exhibits some potential open source projects, however, there are only APIs for specific repository and user. So we will build an unofficial XML-based backend.
- V2EX

  V2EX is a community about technology and design. It provides some APIs for getting latest posts.
- Gank

  Gank.io is a website which provides some interesting frameworks and projects for programmers. Thus, it also pushes some news in software engineering.
- Zhihu

  Zhihu may be the biggest Q&A community in China. We will write a backend with RESTful API, which providing some development-related topic content.

The frontend will integrate lastest and hot information in a list for users. And I plan to implement it on  Web, iOS and Android platform.



## Backend

### GitHub

#### How to Run

```shell
cd DeveloperHit/Backend
go build
./Backend
```

It will run in the ``8000`` port with the url  ``/github``.