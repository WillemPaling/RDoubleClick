RDoubleClick
============

R Client Library for the DoubleClick Campaign Manager Reporting API.

Currently in development, basic retrieval of reports into an R data frame is working as outlined below.

#Install using:

```
library(devtools)
install_github("WillemPaling/RDoubleClick")
```

#Basic commands to get started:

##Authorise with the API
```
client.id <- "yourclientid.apps.googleusercontent.com"
client.secret <- "yourclientsecret"

DCAuth(client.id,client.secret)
```

##Get available profiles (to find your profile ID)
```
profiles <- userprofiles.list()
profileId <- profiles[1,'profileId']
```

##Get available reports (to find a report ID)
```
reports <- reports.list(profileId,results=100)
reportId <- reports[1,'id']
```

##Get available report files and find a report ID and file ID
```
files <- files.list(profileId,reportId,results=100)
reportId <- files[1,'reportId']
fileId <- files[1,'id']
```

##Get the report
```
report <- files.get(fileId,reportId)
```

##Run a report and retrieve it
```
report <- reports.run(profileId,reportId)
```
