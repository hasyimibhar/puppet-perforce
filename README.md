Puppet recipe for [Perforce](http://www.perforce.com/)

## Server 

```puppet
class { 'perforce::server': 
  user => 'perforce',
  password => 'password',
  p4root => '/p4root',
  p4journal => '/var/log/journal',
  p4err => '/var/log/p4err'
  p4port => 1666
}
```

## Client

```puppet
class { 'perforce::client': }
```
