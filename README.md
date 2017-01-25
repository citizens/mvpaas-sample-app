# MVPaaS Sample App
#### This a basic Ruby on Rails application pre-configured to be used with MVPaaS.

### Heroku Setup
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

```
heroku config:set MVPAAS_SECRET=xyz
heroku config:set MVPAAS_URL=http://your-domain.com
heroku run rake db:migrate
```

### Non-Heroku Setup
```
ENV['MVPAAS_SECRET'] = 'xyz'
ENV['MVPAAS_URL'] = 'http://your-domain.com'
rake db:migrate
```



### Screenshots
#### Example of an MVPaaS landing page
![img](https://s3.amazonaws.com/mvpaas-prod/assets/landing-screenshot.png)


#### The MVPaaS Sample App dashboard
![img](https://s3.amazonaws.com/mvpaas-prod/assets/dash-screenshot.png)
