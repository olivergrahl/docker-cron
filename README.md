# A Cron Scheduler for Docker

##Intro

Add an environment variable that starts with `CONTAINER_` and ends with the capitalized name of the container to start. For container names with dashes (`the-name`), use underscores instead (`CONTAINER_THE_NAME`). For container names with underscores (`the_name`), use double underscores instead (`CONTAINER_THE__NAME`). Example:

```yaml
  environment:
    CONTAINER_<container_name>: '*/5 * * * *'
```

##Schedules 
   
Everything you need to know about scheduling can be found in the [fcrontab documentation](http://fcron.free.fr/doc/en/fcrontab.5.html) but simply you can use the cron syntax you are familiar with:

<pre><b>* * * * * *</b>
| | | | | | 
| | | | | +-- Year              (range: 1900-3000)
| | | | +---- Day of the Week   (range: 1-7, 1 standing for Monday)
| | | +------ Month of the Year (range: 1-12)
| | +-------- Day of the Month  (range: 1-31)
| +---------- Hour              (range: 0-23)
+------------ Minute            (range: 0-59)</pre>

You can of course use an online generator such as http://crontab-generator.org/ to help you along.

##Further Info

This scheduler uses [fcron](http://fcron.free.fr/doc/en/fcrontab.5.html) to schedule commands, fcron is great because like anacron it catches up with running services it misses while down. So it's totally okay to change the config and restart the server. 
