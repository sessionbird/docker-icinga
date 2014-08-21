# Icinga docker container

Based on CentOS 7.

**Includes**: Icinga 2 + Nagios plugins + classic web UI.

**NOT included**: Icinga-web and configuration (hosts, checks).

## Configuration

* In `contacts.cfg` change your email information (under `contact`, `email`).

* The default user + password for the web-ui are `icingaadmin` with password `admin`. Configure your own via:

        htpasswd -c htpasswd.users icingaadmin

* Once everything builds and runs, add your own configuration files to the end of `Dockerfile`

        ADD hosts.cfg /usr/local/icinga/etc/conf.d/hosts.cfg
        ADD services.cfg /usr/local/icinga/etc/conf.d/services.cfg

## Use

```
docker build -t icinga:1.11.5 .
docker run -p 8080:80 icinga:1.11.5
```

Now your browser at `http://localhost:8080/icinga/`.

## Kudos

* Thanks to [Adrian Diu's](http://linoxide.com/author/adriand/) guide on [LinOxide](http://linoxide.com/monitoring-2/install-configure-icinga-linux/)!

## License

Copyright 2014, Dominik Richter

Copyright 2014, Sessionbird GmbH

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
