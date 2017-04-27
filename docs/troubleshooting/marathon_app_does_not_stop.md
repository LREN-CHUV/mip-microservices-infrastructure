

List the id of all applications:
http GET http://hbpfedqa1:5080/v2/apps/ | jq '.apps[].id'

http DELETE "http://hbpfedqa1:5080/v2/apps//algorithm-factory/chronos/?force=true&wipe=true"
