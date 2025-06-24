This file is a merged representation of the entire codebase, combined into a single document by Repomix.
The content has been processed where security check has been disabled.

<file_summary>
This section contains a summary of this file.

<purpose>
This file contains a packed representation of the entire repository's contents.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.
</purpose>

<file_format>
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Repository files (if enabled)
5. Multiple file entries, each consisting of:
  - File path as an attribute
  - Full contents of the file
</file_format>

<usage_guidelines>
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.
</usage_guidelines>

<notes>
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Security check has been disabled - content may contain sensitive information
- Files are sorted by Git change count (files with more changes are at the bottom)
</notes>

</file_summary>

<directory_structure>
.github/
  ISSUE_TEMPLATE/
    proposal-to-add-factor.md
    proposal-to-change-core-principles.md
    proposal-to-remove-factor.md
    proposal-to-update-factor.md
content/
  admin-processes.md
  background.md
  backing-services.md
  build-release-run.md
  codebase.md
  concurrency.md
  config.md
  dependencies.md
  dev-prod-parity.md
  disposability.md
  intro.md
  logs.md
  port-binding.md
  processes.md
  toc.md
  who.md
CODEOWNERS
CONTRIBUTING.md
GOVERNANCE.md
LICENSE
MAINTAINERS.md
README.md
UPDATE_FAQ.md
VISION.md
</directory_structure>

<files>
This section contains the contents of the repository's files.

<file path=".github/ISSUE_TEMPLATE/proposal-to-add-factor.md">
---
name: Proposal for New Factor
about: Large Change -- Adding a new factor
title: Proposal to Add [Factor Title]
labels: large change, proposal
assignees: ''

---

> Describe the factor you'd like to include and why. Include why you think it
> fits with the [vision](VISION.md).
</file>

<file path=".github/ISSUE_TEMPLATE/proposal-to-change-core-principles.md">
---
name: Proposal for Change to Core Principles
about: Large Change -- Substantial alteration to core principles
title: Proposal to Change [Vision/Intro]
labels: large change, proposal
assignees: ''

---

> Describe what in the [vision](VISION.md) or [introduction](content/intro.md)
> you think should be changed and why.
</file>

<file path=".github/ISSUE_TEMPLATE/proposal-to-remove-factor.md">
---
name: Proposal to Remove Factor
about: Large Change -- Removing an existing factor
title: Proposal to Remove [Factor Title]
labels: large change, proposal
assignees: ''

---

> Explain which factor you think should be removed and why.
</file>

<file path=".github/ISSUE_TEMPLATE/proposal-to-update-factor.md">
---
name: Proposal for Updating Scope of Factor
about: Medium Change - Significant modifications to an existing factor
title: Proposal to Modify Factor [Factor Title]
labels: medium change, proposal
assignees: ''

---

> Describe the proposed changes to the factor. Why does it need to be changed?
> What are the benefits?
</file>

<file path="content/admin-processes.md">
## XII. Admin processes

### Run admin/management tasks as one-off processes

#### 1. A twelve-factor app distinguishes between its regular business processes and one-off administrative tasks.

The [process formation](./concurrency.md) defines the array of processes used to
run the app’s regular operations (such as handling web requests). Separately,
developers often need to perform ad hoc administrative or maintenance tasks.

##### Examples

Administrative tasks include:

- Running database migrations (e.g. `manage.py migrate` in Django,
  `rake db:migrate` in Rails).
- Launching a REPL (Read-Eval-Print Loop) shell to execute arbitrary code or
  inspect the app’s models against the live database.
- Executing one-time scripts committed into the app’s repository (e.g.
  `php scripts/fix_bad_records.php`).

#### 2. A twelve-factor app runs admin processes in an environment identical to its long-running processes.

Admin processes are executed against a [release](./build-release-run.md) using
the same [codebase](./codebase.md) and [config](./config.md) as all other
processes. This ensures consistency and prevents synchronization issues between
administrative tasks and the running app.

##### Examples

The same [dependency isolation](./dependencies.md) techniques apply to every
process type. For instance, if a Ruby web process is started with
`bundle exec thin start`, then a database migration should be run with
`bundle exec rake db:migrate`. Likewise, a Python application using Virtualenv
should invoke the vendored `bin/python` for both the web server and any
`manage.py` admin tasks.

##### Guidance

In local deployments, one-off admin processes are invoked directly via shell
commands within the app’s checkout directory. In production, such tasks are
executed using SSH or another remote command execution mechanism provided by the
deployment environment.
</file>

<file path="content/background.md">
Background
==========

The contributors to this document have been directly involved in the development and deployment of hundreds of apps, and indirectly witnessed the development, operation, and scaling of hundreds of thousands of apps via our work on the <a href="http://www.heroku.com/" target="_blank">Heroku</a> platform.

This document synthesizes all of our experience and observations on a wide variety of software-as-a-service apps in the wild.  It is a triangulation on ideal practices for app development, paying particular attention to the dynamics of the organic growth of an app over time, the dynamics of collaboration between developers working on the app's codebase, and <a href="http://blog.heroku.com/archives/2011/6/28/the_new_heroku_4_erosion_resistance_explicit_contracts/" target="_blank">avoiding the cost of software erosion</a>.

Our motivation is to raise awareness of some systemic problems we've seen in modern application development, to provide a shared vocabulary for discussing those problems, and to offer a set of broad conceptual solutions to those problems with accompanying terminology.  The format is inspired by Martin Fowler's books *<a href="https://books.google.com/books/about/Patterns_of_enterprise_application_archi.html?id=FyWZt5DdvFkC" target="_blank">Patterns of Enterprise Application Architecture</a>* and *<a href="https://books.google.com/books/about/Refactoring.html?id=1MsETFPD3I0C" target="_blank">Refactoring</a>*.
</file>

<file path="content/backing-services.md">
## IV. Backing services

### Treat backing services as attached resources

#### 1. A twelve-factor app relies on backing services for normal operation.

A _backing service_ is any service the app consumes over the network as part of
its normal operation.

##### Examples

Examples include datastores (such as [MySQL](http://dev.mysql.com/) or
[CouchDB](http://couchdb.apache.org/)), messaging/queueing systems (such as
[RabbitMQ](http://www.rabbitmq.com/) or
[Beanstalkd](https://beanstalkd.github.io)), SMTP services for outbound email
(such as [Postfix](http://www.postfix.org/)), and caching systems (such as
[Memcached](http://memcached.org/)).

#### 2. A twelve-factor app treats each distinct backing service as an attachable resource.

Each distinct backing service is a _resource_, indicating its loose coupling to
the deploy it is attached to.

##### Examples

A MySQL database is a resource; two MySQL databases (used for sharding at the
application layer) qualify as two distinct resources.

![A production deploy attached to four backing services.](/images/attached-resources.png)

##### Guidance

Resources can be attached to and detached from deploys at will. For example, if
the app’s database is misbehaving due to a hardware issue, the app’s
administrator might spin up a new database server restored from a recent backup.
The current production database could be detached, and the new database
attached—all without any code changes.

#### 3. A twelve-factor app references all services with a connection string stored in config.

Backing services like the database are traditionally managed by the same systems
administrators who deploy the app's runtime. In addition to these
locally-managed services, the app may also have services provided and managed by
third parties. The code for a twelve-factor app makes no distinction between
local and third-party services; to the app, both are _attached resources_,
accessed via a URL or other locator/credentials stored in the
[config](./config.md).

##### Examples

Examples of third-party services include SMTP services (such as
[Postmark](http://postmarkapp.com/)), metrics-gathering services (such as
[New Relic](http://newrelic.com/) or [Loggly](http://www.loggly.com/)), binary
asset services (such as [Amazon S3](http://aws.amazon.com/s3/)), and even
API-accessible consumer services (such as [Twitter](http://dev.twitter.com/),
[Google Maps](https://developers.google.com/maps/), or
[Last.fm](http://www.last.fm/api)).

##### Guidance

A [deploy](./codebase.md) of the twelve-factor app should be able to swap out a
local MySQL database with one managed by a third party (such as
[Amazon RDS](http://aws.amazon.com/rds/)) without any changes to the app's code.
Likewise, a local SMTP server could be swapped with a third-party SMTP service
(such as Postmark) without code changes. In both cases, only the resource handle
in the config needs to change.
</file>

<file path="content/build-release-run.md">
## V. Build, release, run
### Strictly separate build and run stages

#### 1\. An app has distinct build, release, and run stages

A [codebase](./codebase.md) is transformed into a (non-development) deploy
through three stages:

* The *build stage* is a transform which converts a code repo into an
  executable bundle known as a *build*. Using a version of the code at a commit
  specified by the deployment process, the build stage fetches vendors
  [dependencies](./dependencies.md) and compiles binaries and assets.
* The *release stage* takes the build produced by the build stage and combines
  it with the deploy’s current [config](./config.md). The resulting *release*
  contains both the build and the config and is ready for immediate execution
  in the execution environment.
* The *run stage* (also known as "runtime") runs the app in the execution
  environment, by launching some set of the app’s [processes](./processes.md)
  against a selected release.

The twelve-factor app enforces strict separation between the build, release,
and run stages.

##### Examples

It is impossible to make changes to the code at runtime, since there is no way
to propagate those changes back to the build stage. Deployment tools typically
offer release management tools, most notably the ability to roll back to a
previous release.

#### 2\. Each release is a unique, immutable snapshot

Every release should always have a unique release ID, such as a timestamp of
the release (for example, `2011-04-06-20:32:17`) or an incrementing number
(such as `v100`). Releases are an append-only ledger and a release cannot be
mutated once it is created.

##### Guidance

Any change must create a new release.

##### Examples

For example, the [Capistrano](https://github.com/capistrano/capistrano/wiki)
deployment tool stores releases in a subdirectory named `releases`, where the
current release is a symlink to the current release directory. Its `rollback`
command makes it easy to quickly roll back to a previous release.

#### 3\. Push deployment complexity into the build stage and keep run minimal

Builds are initiated by the app’s developers whenever new code is deployed.
Runtime execution, by contrast, can happen automatically in cases such as a
server reboot or a crashed process being restarted by the process manager.

##### Guidance

Therefore, the run stage should be kept to as few moving parts as possible,
since problems that prevent an app from running can cause it to break in the
middle of the night when no developers are on hand. The build stage can be more
complex, since errors are always in the foreground for a developer who is
driving the deploy.
</file>

<file path="content/codebase.md">
## I. Codebase
### One codebase tracked in revision control, many deploys

#### 1. A twelve-factor app is always tracked in a version control system.

A twelve-factor app is always tracked in a version control system. A copy of 
the revision tracking database is known as a *code repository*, often shortened 
to *code repo* or just *repo*.

##### Examples

Examples of version control systems include 
[Git](http://git-scm.com/), [Mercurial](https://www.mercurial-scm.org/), 
and [Subversion](http://subversion.apache.org/).

##### Guidance

A *codebase* is any single repo (in a centralized revision control system like 
Subversion), or any set of repos that share a root commit (in a decentralized 
revision control system like Git).

#### 2. There is always a one-to-one correlation between the codebase and the app.

There is always a one-to-one correlation between the codebase and the app:

* If there are multiple codebases, it’s not an app — it’s a distributed system. 
  Each component in a distributed system is an app, and each can individually 
  comply with twelve-factor.
* Multiple apps sharing the same code is a violation of twelve-factor.

![One codebase maps to many deploys](/images/codebase-deploys.png)

##### Guidance

If multiple apps need to share functionality, factor out the shared code into 
libraries that can be included through the [dependency manager](./dependencies.md).

#### 3. One codebase can be deployed in multiple environments.

There is only one codebase per app, but there will be many deploys of the app. 
A *deploy* is a running instance of the app, typically a production site plus 
one or more staging sites. Additionally, every developer has a copy of the app 
running in their local development environment, each of which also qualifies 
as a deploy.

The codebase is the same across all deploys, although different versions may be 
active in each deploy. For example, a developer may have some commits not yet 
deployed to staging; staging may have some commits not yet deployed to 
production. But they all share the same codebase, making them identifiable as 
different deploys of the same app.
</file>

<file path="content/concurrency.md">
## VIII. Concurrency
### Scale out via the process model

#### 1. Any computer program, once run, is represented by one or more processes

Any computer program, once run, is represented by one or more processes. Web
apps have taken a variety of process-execution forms, and in many cases the
running process(es) are only minimally visible to the developers of the app.

##### Examples
- PHP processes run as child processes of Apache, started on demand as needed
  by request volume.
- Java processes often take the opposite approach, with the JVM providing one
  large “uberprocess” that reserves a block of system resources on startup,
  managing concurrency internally via threads.

![Scale is expressed as running processes, workload diversity is expressed as process types.](/images/process-types.png)

#### 2. A twelve-factor app treats processes as first-class citizens

**In the twelve-factor app, processes are a first class citizen.** Processes in
the twelve-factor app take strong cues from [the unix process model for running
service
daemons](https://adam.herokuapp.com/past/2011/5/9/applying_the_unix_process_model_to_web_apps/).

#### 3. A twelve-factor app scales out by assigning workloads to separate process types

Using this model, the developer can architect the app to handle diverse
workloads by assigning each type of work to a *process type*. For example, HTTP
requests may be handled by a web process, and long-running background tasks
handled by a worker process.

This does not exclude individual processes from handling their own internal
multiplexing, via threads inside the runtime VM or the async/evented model
found in tools such as
[EventMachine](https://github.com/eventmachine/eventmachine),
[Twisted](http://twistedmatrix.com/trac/), or [Node.js](http://nodejs.org/).
But an individual VM can only grow so large (vertical scale), so the
application must also be able to span multiple processes running on multiple
physical machines.

The process model truly shines when it comes time to scale out. The
[share-nothing, horizontally partitionable nature of twelve-factor app
processes](./processes) means that adding more concurrency is a simple and
reliable operation. The array of process types and the number of processes of
each type is known as the *process formation*.

#### 4. A twelve-factor app relies on the execution environment to manage processes

Twelve-factor app processes [should never
daemonize](https://web.archive.org/web/20190827220442/http://dustin.sallings.org/2010/02/28/running-processes.html)
or write PID files.

##### Guidance
Instead, rely on the operating system's process manager (such as
[systemd](https://www.freedesktop.org/wiki/Software/systemd/), a distributed
process manager on a cloud platform, or a tool like
[Foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html) in
development) to manage [output streams](./logs), respond to crashed processes,
and handle user-initiated restarts and shutdowns.
</file>

<file path="content/config.md">
## III. Config
### Store config in the environment

#### 1\. A twelve-factor app strictly separates config from code

An app's *config* is everything that is likely to vary between [deploys](./codebase.md)
(staging, production, developer environments, etc). Config varies substantially across
deploys; code does not. Apps sometimes store config as constants in the code. This is a
violation of twelve-factor, which requires **strict separation of config from code**.

A litmus test for whether an app has all config correctly factored out of the code is
whether the codebase could be made open source at any moment, without compromising any
credentials.

Note that this definition of "config" does **not** include internal application config,
such as `config/routes.rb` in Rails, or how
[code modules are connected](http://docs.spring.io/spring/docs/current/spring-framework-reference/html/beans.html)
in [Spring](http://spring.io/). This type of config does not vary between deploys, and so
is best done in the code.

##### Examples

- Resource handles to the database, Memcached, and other [backing services](./backing-services.md)
- Credentials to external services such as Amazon S3 or X (formerly Twitter)
- Per-deploy values such as the canonical hostname for the deploy

#### 2\. A twelve-factor app stores config in environment variables

Another approach to config is the use of config files which are not checked into
revision control, such as `config/database.yml` in Rails. This is a huge improvement over
using constants which are checked into the code repo, but still has weaknesses: it's easy
to mistakenly check in a config file to the repo; there is a tendency for config files
to be scattered about in different places and different formats, making it hard to see
and manage all the config in one place. Further, these formats tend to be language- or
framework-specific.

**The twelve-factor app stores config in *environment variables*** (often shortened to
*env vars* or *env*). Env vars are easy to change between deploys without changing any
code; unlike config files, there is little chance of them being checked into the code
repo accidentally; and unlike custom config files, or other config mechanisms such as
Java System Properties, they are a language- and OS-agnostic standard.

#### 3\. A twelve-factor app treats env vars as granular controls, never grouped by environment

Another aspect of config management is grouping. Sometimes apps batch config into named
groups (often called "environments") named after specific deploys, such as the
`development`, `test`, and `production` environments in Rails. This method does not scale
cleanly: as more deploys of the app are created, new environment names are necessary,
such as `staging` or `qa`. As the project grows further, developers may add their own
special environments like `joes-staging`, resulting in a combinatorial explosion of config
which makes managing deploys of the app very brittle.

In a twelve-factor app, env vars are independently managed for each deploy. They are never
grouped together as "environments," but instead are treated as granular controls. This
model scales up smoothly as the app naturally expands into more deploys over its lifetime.
</file>

<file path="content/dependencies.md">
## II. Dependencies

### Explicitly declare and isolate dependencies

#### 1\. A twelve-factor app is built and run in deterministic environments.

One benefit of explicit dependency declaration is that it simplifies setup for developers new to the app. The new developer can check out the app’s codebase onto their development machine, requiring only the language runtime and dependency manager installed as prerequisites. They will be able to set up everything needed to run the app’s code with a deterministic build command.

##### Examples

For example, the build command for Ruby/Bundler is bundle install, while for Clojure/Leiningen it is lein deps.

#### 2\. A twelve-factor app does not rely on the implicit existence of system-wide packages.

It declares all dependencies, completely and exactly, via a dependency declaration manifest. Furthermore, it uses a dependency isolation tool during execution to ensure that no implicit dependencies "leak in" from the surrounding system. The full and explicit dependency specification is applied uniformly to both production and development.

##### Examples

Bundler for Ruby offers the Gemfile manifest format for dependency declaration and bundle exec for dependency isolation. In Python there are two separate tools for these steps – Pip is used for declaration and Virtualenv for isolation. Even C has Autoconf for dependency declaration, and static linking can provide dependency isolation. No matter what the toolchain, dependency declaration and isolation must always be used together – only one or the other is not sufficient to satisfy twelve-factor.

#### 3\. A twelve-factor app does not rely on the implicit existence of any system tools.

While these tools may exist on many or even most systems, there is no guarantee that they will exist on all systems where the app may run in the future, or whether the version found on a future system will be compatible with the app.

##### Examples

Examples include shelling out to ImageMagick or curl.

##### Guidance

If the app needs to shell out to a system tool, that tool should be vendored into the app.
</file>

<file path="content/dev-prod-parity.md">
## X. Dev/prod parity

### Keep development, staging, and production as similar as possible

#### 1. A twelve-factor app minimizes the gaps between development, staging, and production.

Historically, there have been substantial gaps between development (a developer
making live edits to a local [deploy](./codebase.md) of the app) and production
(a running deploy of the app accessed by end users). These gaps manifest in
three areas:

- **The time gap**: A developer may work on code that takes days, weeks, or even
  months to go into production.
- **The personnel gap**: Developers write code, ops engineers deploy it.
- **The tools gap**: Developers may be using a stack like Nginx, SQLite, and
  OS X, while the production deploy uses Apache, MySQL, and Linux.

**The twelve-factor app is designed for
[continuous deployment](http://avc.com/2011/02/continuous-deployment/) by
keeping the gap between development and production small.**

|                               | Traditional app  | Twelve-factor app      |
| ----------------------------- | ---------------- | ---------------------- |
| **Time between deploys**      | Weeks            | Hours                  |
| **Code authors vs deployers** | Different people | Same people            |
| **Dev vs production**         | Divergent        | As similar as possible |

##### Guidance

- Make the time gap small: a developer may write code and have it deployed hours
  or even just minutes later.
- Make the personnel gap small: developers who wrote code are closely involved
  in deploying it and watching its behavior in production.
- Make the tools gap small: keep development and production as similar as
  possible.

#### 2. A twelve-factor app uses the same backing services in all deploys.

[Backing services](./backing-services.md), such as the app's database, queueing
system, or cache, are a key area where dev/prod parity is important. Many
languages offer libraries which simplify access to the backing service,
including _adapters_ to different types of services.

| Type     | Language      | Library              | Adapters                      |
| -------- | ------------- | -------------------- | ----------------------------- |
| Database | Ruby/Rails    | ActiveRecord         | MySQL, PostgreSQL, SQLite     |
| Queue    | Python/Django | Celery               | RabbitMQ, Beanstalkd, Redis   |
| Cache    | Ruby/Rails    | ActiveSupport::Cache | Memory, filesystem, Memcached |

Developers sometimes find great appeal in using a lightweight backing service in
their local environments, while a more robust backing service is used in
production. For example, using SQLite locally and PostgreSQL in production; or
local process memory for caching in development and Memcached in production.

**The twelve-factor developer resists the urge to use different backing services
between development and production**; tiny incompatibilities can cause code that
worked in development or staging to fail in production, creating friction that
disincentivizes continuous deployment and incurs high costs over the lifetime of
an application.

##### Guidance

All deploys of the app (developer environments, staging, production) should use
the same type and version of each backing service. Modern backing services such
as Memcached, PostgreSQL, and RabbitMQ are not difficult to install and run
thanks to modern packaging systems like
[Homebrew](http://mxcl.github.com/homebrew/) and
[apt-get](https://help.ubuntu.com/community/AptGet/Howto). Declarative
provisioning tools such as [Chef](http://www.opscode.com/chef/) and
[Puppet](http://docs.puppetlabs.com/), combined with lightweight virtual
environments such as [Docker](https://www.docker.com/) and
[Vagrant](http://vagrantup.com/), enable developers to run local environments
that closely approximate production.
</file>

<file path="content/disposability.md">
## IX. Disposability

### Maximize robustness with fast startup and graceful shutdown

#### 1. A twelve-factor app’s processes are disposable.

Processes are designed to be started or stopped at a moment’s notice. This
disposability underpins fast elastic scaling, rapid deployment of code or config
changes, and overall production robustness.

##### Examples

Disposable processes allow an app to quickly adapt to changing load or updated
releases by simply replacing processes without lengthy downtime.

#### 2. A twelve-factor app’s processes minimize startup time.

Processes should start in just a few seconds from the moment the launch command
is executed until they are ready to receive requests or jobs. A fast startup is
key to agile releases and dynamic scaling.

##### Guidance

Aim for minimal startup time so that process managers can efficiently move
processes to new machines and support rapid deployment cycles.

#### 3. A twelve-factor app’s processes shut down gracefully.

Processes are expected to handle a
[SIGTERM](http://en.wikipedia.org/wiki/SIGTERM) signal by cleaning up and
exiting in a controlled manner, thereby avoiding abrupt terminations.

##### Examples

For a web process, graceful shutdown is achieved by ceasing to listen on the
service port—refusing new requests while allowing current ones to finish. For a
worker process, it means returning the current job to the work queue (for
example, by sending a `NACK` on [RabbitMQ](http://www.rabbitmq.com/), relying on
automatic job return on [Beanstalkd](https://beanstalkd.github.io/), or
releasing a lock in systems like
[Delayed Job](https://github.com/collectiveidea/delayed_job#readme)).

##### Guidance

Implement shutdown procedures that allow your processes to complete in-flight
tasks or safely return work, ensuring that deployments and scaling events cause
minimal disruption.

#### 4. A twelve-factor app’s processes are robust against sudden termination.

Even in cases of unexpected, non-graceful shutdown—such as hardware
failures—processes are architected to recover without data loss or corruption.

##### Examples

Using a robust queuing backend, such as Beanstalkd, ensures that jobs are
returned to the queue when a process disconnects or times out. Embracing
crash-only design principles further reinforces system resilience.

##### Guidance

Design your app so that any in-progress work can be recovered or retried
automatically, handling unexpected process death with minimal manual
intervention.
</file>

<file path="content/intro.md">
Introduction
============

In the modern era, software is commonly delivered as a service: called *web apps*, or *software-as-a-service*.  The twelve-factor app is a methodology for building software-as-a-service apps that:

* Use **declarative** formats for setup automation, to minimize time and cost for new developers joining the project;
* Have a **clean contract** with the underlying operating system, offering **maximum portability** between execution environments;
* Are suitable for **deployment** on modern **cloud platforms**, obviating the need for servers and systems administration;
* **Minimize divergence** between development and production, enabling **continuous deployment** for maximum agility;
* And can **scale up** without significant changes to tooling, architecture, or development practices.

The twelve-factor methodology can be applied to apps written in any programming language, and which use any combination of backing services (database, queue, memory cache, etc).
</file>

<file path="content/logs.md">
## XI. Logs
### Treat logs as event streams

#### 1\. A twelve-factor app produces logs as a stream of time-ordered events.

*Logs* provide visibility into the behavior of a running app. Logs are the
[stream](https://adam.herokuapp.com/past/2011/4/1/logs_are_streams_not_files/)
of aggregated, time-ordered events collected from the output streams of all
running processes and backing services. Logs have no fixed beginning or end,
but flow continuously as long as the app is operating.

##### Examples

Logs in their raw form are typically a text format with one event per line
(though backtraces from exceptions may span multiple lines).

In server-based environments, logs are commonly written to a file on disk (a
"logfile"); but this is only an output format. During local development, the
developer views the log stream in the foreground of their terminal to observe
the app’s behavior.

##### Guidance

Each running process writes its event stream, unbuffered, to `stdout`.

#### 2\. A twelve-factor app never concerns itself with routing or storage of its output stream.

It should not attempt to write to or manage logfiles. The handling of log
streams, including capturing, routing, and storing them, is the responsibility
of the execution environment. This allows the event stream for an app to be
routed to a file, or watched via real-time tail in a terminal.

##### Examples

The stream can be sent to a log indexing and analysis system such as
[Splunk](http://www.splunk.com/), or a general-purpose data warehousing system
such as [Hadoop/Hive](http://hive.apache.org/).  These systems allow for great
power and flexibility for introspecting an app's behavior over time, including:

* Finding specific events in the past.
* Large-scale graphing of trends (such as requests per minute).
* Active alerting according to user-defined heuristics (such as an alert when
  the quantity of errors per minute exceeds a certain threshold).

##### Guidance

In staging or production deploys, each process' stream will be captured by the
execution environment, collated together with all other streams from the app,
and routed to one or more final destinations for viewing and long-term
archival.  These archival destinations are not visible to or configurable by
the app, and instead are completely managed by the execution environment.
Open-source log routers (such as [Logplex](https://github.com/heroku/logplex)
and [Fluentd](https://github.com/fluent/fluentd)) are available for this
purpose.
</file>

<file path="content/port-binding.md">
## VII. Port binding

### Export services via port binding

#### 1. A twelve-factor app is completely self-contained and exports HTTP as a service by binding to a port.

Web apps are sometimes executed inside a webserver container. For example, PHP
apps might run as a module inside [Apache HTTPD](http://httpd.apache.org/), or
Java apps might run inside [Tomcat](http://tomcat.apache.org/). **The
twelve-factor app is completely self-contained** and does not rely on runtime
injection of a webserver into the execution environment to create a web-facing
service. Instead, the web app **exports HTTP as a service by binding to a port**
and listening to requests coming in on that port.

##### Examples

In a local development environment, the developer visits a service URL like
`http://localhost:5000/` to access the service exported by their app. In
deployment, a routing layer handles routing requests from a public-facing
hostname to the port-bound web processes.

##### Guidance

This pattern is typically implemented by using
[dependency declaration](./dependencies.md) to add a webserver library to the
app—such as [Tornado](http://www.tornadoweb.org/) for Python,
[Thin](https://github.com/macournoyer/thin) for Ruby, or
[Jetty](http://www.eclipse.org/jetty/) for Java and other JVM-based languages.
This happens entirely in _user space_, within the app’s code, fulfilling the
contract with the execution environment of binding to a port to serve requests.

#### 2. Port binding enables any service to be exported and allows an app to serve as a backing service.

HTTP is not the only service that can be exported by port binding. Nearly any
kind of server software can be run via a process binding to a port and awaiting
incoming requests.

##### Examples

Examples include [ejabberd](http://www.ejabberd.im/) (speaking
[XMPP](http://xmpp.org/)) and [Redis](http://redis.io/) (speaking the
[Redis protocol](http://redis.io/topics/protocol)). Note also that the
port-binding approach means that one app can become the
[backing service](./backing-services.md) for another app, by providing the URL
to the backing app as a resource handle in the [config](./config.md) for the
consuming app.

##### Guidance

Design your application such that all service exports occur via port binding,
ensuring that the app remains self-contained and independent of runtime
webserver injection.
</file>

<file path="content/processes.md">
## VI. Processes
### Execute the app as one or more stateless processes

#### 1. A twelve-factor app runs as one or more processes.

The app is executed in the execution environment as one or more *processes*.

##### Examples

In the simplest case, the code is a stand-alone script, the execution
environment is a developer’s local laptop with an installed language runtime,
and the process is launched via the command line (for example, `python
my_script.py`).

On the other end of the spectrum, a production deploy of a sophisticated app
may use many [process types, instantiated into zero or more running
processes](./concurrency.md).

#### 2. A twelve-factor app’s processes are stateless and share nothing.

Any data that needs to persist must be stored in a stateful [backing
service](./backing-services.md), typically a database. The memory space or
filesystem of the process can be used as a brief, single-transaction cache (for
example, downloading a large file, operating on it, and storing the results of
the operation in the database). However, the twelve-factor app never assumes
that anything cached in memory or on disk will be available on a future request
or job.

With many processes of each type running, chances are high that a future
request will be served by a different process. Even when running only one
process, a restart (triggered by code deploy, config change, or the execution
environment relocating the process to a different physical location) will
usually wipe out all local (e.g., memory and filesystem) state.

##### Examples

Asset packagers like
[django-assetpackager](http://code.google.com/p/django-assetpackager/) use the
filesystem as a cache for compiled assets. A twelve-factor app prefers to do
this compiling during the [build stage](/build-release-run). Asset packagers
such as [Jammit](http://documentcloud.github.io/jammit/) and the [Rails asset
pipeline](http://ryanbigg.com/guides/asset_pipeline.html) can be configured to
package assets during the build stage.

##### Guidance

Some web systems rely on ["sticky
sessions"](http://en.wikipedia.org/wiki/Load_balancing_%28computing%29#Persistence)
— that is, caching user session data in memory of the app’s process and
expecting future requests from the same visitor to be routed to the same
process. Sticky sessions are a violation of twelve-factor and should never be
used or relied upon. Session state data is a good candidate for a datastore that offers
time-expiration, such as [Memcached](http://memcached.org/) or
[Redis](http://redis.io/).
</file>

<file path="content/toc.md">
The Twelve Factors
==================

## [I. Codebase](./codebase.md)
### One codebase tracked in revision control, many deploys

## [II. Dependencies](./dependencies.md)
### Explicitly declare and isolate dependencies

## [III. Config](./config.md)
### Store config in the environment

## [IV. Backing services](./backing-services.md)
### Treat backing services as attached resources

## [V. Build, release, run](./build-release-run.md)
### Strictly separate build and run stages

## [VI. Processes](./processes.md)
### Execute the app as one or more stateless processes

## [VII. Port binding](./port-binding.md)
### Export services via port binding

## [VIII. Concurrency](./concurrency.md)
### Scale out via the process model

## [IX. Disposability](./disposability.md)
### Maximize robustness with fast startup and graceful shutdown

## [X. Dev/prod parity](./dev-prod-parity.md)
### Keep development, staging, and production as similar as possible

## [XI. Logs](./logs.md)
### Treat logs as event streams

## [XII. Admin processes](./admin-processes.md)
### Run admin/management tasks as one-off processes
</file>

<file path="content/who.md">
Who should read this document?
==============================

Any developer building applications which run as a service.  Ops engineers who deploy or manage such applications.
</file>

<file path="CODEOWNERS">
*   @twelve-factor/maintainers
</file>

<file path="CONTRIBUTING.md">
# Contributing to the Twelve-Factor Project

Thank you for your interest in contributing to the twelve-factor manifesto!
This guide will help you get started with contributing to the project in a way
that aligns with our community values and governance structure.

## Getting Started

1. **Familiarize Yourself with the Project**
   - Begin by reviewing the [Twelve-Factor Manifesto](https://12factor.net) to
     see the current state.
   - Check out the [Twelve-Factor Vision](VISION.md) to understand the
     project's goals and principles.
   - Take a look at the [Twelve-Factor Governance document](GOVERNANCE.md) to
     familiarize yourself with how we operate.

2. **Find an Area to Contribute**
   - Contributions come in many forms: documentation, bug fixes, new features,
     or participating in discussions.
   - Look for open issues on our GitHub repository that are tagged as [good
     first issue](../../issues?q=is%3Aissue+is%3Aopen+label%3Agood+first+issue)
     for beginners, or explore areas where you feel you can provide value.

3. **Join the Discussion**
   - Engaging with the community is crucial to contributing. You can:
     - Participate in discussions on [open issues](../../issues).
     - Broader discussions often happen on the [mailing
       list](https://groups.google.com/g/twelve-factor)
     - Near real-time collaboration happens on
       [discord](https://discord.gg/9HFMDMt95z)
   - Respectful dialogue and collaboration a key to our community's success.

## How to Contribute

### Code Contributions

1. **Fork the Repository**
   - Create a personal fork of the [twelve-factor
     repository](https://github.com/twelve-factor/twelve-factor).
2. **Clone Your Fork**
   - Clone your fork to your local development environment targeting the
     `next` branch.
   ```bash
   git clone -b next https://github.com/your-username/twelve-factor.git
   cd twelve-factor
   ```
3. **Create a new Branch**
    ```bash
    git checkout -b your-branch-name
    ```
4. **Make Your Changes**
   - Ensure your changes adhere to the project’s guidelines.
5. **Submit a Pull Request**
   - Push your changes to your fork and submit a pull request (PR) to the main
     repository.
   - In your PR description, link to any relevant issues and explain the
     purpose and scope of your changes.
6. **Review Process**
   - A [maintainer](MAINTAINERS.md) will review your pull request. Feedback
     might be provided to help align your contribution with the project’s
     standards.
   - Small changes require sign-off from one maintainer, while medium and large
     changes will undergo a broader review process as outlined in the
     [governance document](GOVERNANCE.md).
</file>

<file path="GOVERNANCE.md">
# Twelve-Factor Governance

This document defines the governance structure for the twelve-factor manifesto
maintained at [https://12factor.net](https://12factor.net). This project is
committed to building an open, inclusive, productive and self-governing open
source community. The guidelines herein describe how the twelve-factor
community should work together to achieve this goal.

## Membership

A member of the project is a person who has contributed to twelve-factor via
source code, documentation, pull requests, issues, or discussions. A member may
additionally have one of the roles listed below. Roles are tied to individuals,
not companies. Therefore a person leaving a role from a company cannot transfer
the role to someone else in that company.

### Maintainers

Maintainers are members who are in charge of the day-to-day work of the project
and its technical governing body. The [maintainership group](MAINTAINERS.md) should be
sufficiently large to provide diverse perspectives and ensure sustainable
governance, ideally comprising more than ten but fewer than fifty members.
Maintainers oversee all aspects of the project and have a mandate to drive
consensus for:

* Defining and maintaining the mission and charter for the project.
* Fostering a healthy and welcoming community, including by defining and
  enforcing our Code of Conduct.
* Defining the governance structure of the project including how changes are
  proposed and merged.
* Anything else that falls through the cracks.

New maintainers must be nominated by existing maintainers and elected by a
(66%+) supermajority of the maintainers. Maintainers may graduate to emeritus
status by request or by a super-majority vote of the rest of the maintainers.

### Contributors

Contributors are members who make regular contributions (documentation,
reviews, responding to issues, participation in proposal discussions, code,
etc.) and are therefore granted additional permissions (triaging issues,
merging approved PRs, pushing to non-protected branches) that support those
activities.

New contributors may be self-nominated or be nominated by existing
contributors, and must be approved by a super-majority of the maintainers.
Likewise, contributors may resign or can be removed by a super-majority of
maintainers.

### Emeritus

Serving as a member of an open source project requires a significant amount of
work that cannot be sustained indefinitely. The project recognizes emeritus
members to whom we will always be grateful, but who no longer actively
participate in the project.

Project members should graduate to emeritus status through self-nomination when
they no longer intend to actively fulfill an assigned role in the project.
Members holding multiple roles may choose emeritus status for one role while
retaining other roles.

As a guideline, when members have not been active contributors for longer than
3 months they should be nominated to be moved to emeritus. Out of courtesy, a
notice for nomination should be given to members that fall under this category
prior to being nominated.

If emeritus members in a leadership position in the project wish to regain an
active role, they may skip the normal nomination process and can do so by
renewing their contributions for at least two weeks and contacting an existing
maintainer to review their work and mark them active again.

## Change Management Process

The twelve-factor manifesto is treated as a foundational reference, so changes
follow a defined process:

* **Change Principles**: To accept or reject a change, the following principles
  will be used:
  * Changes should align with the core values and objectives in the
    [Twelve-Factor Vision](VISION.md).
  * Consensus among maintainers is preferred, aiming for broad agreement.
* **Change Approval**: Changes require different levels of approval depending
  on their significance. Medium and large changes should be open for feedback
  for a minimum of one week. This ensures the community has time to comment.
  Members can \-1 the change to represent concerns that need to be discussed. A
  vote should only be held if consensus cannot be reached.
  * **Small Changes**: These include minor updates such as grammar corrections,
    clarifications, or updates to examples. Small changes require sign-off from
    at least one maintainer, with no active maintainer concerns.
  * **Medium Changes**: These include significant modifications to an existing
    factor, such as changing recommendations or updating the scope of a factor.
    Medium changes require sign-off from at least three maintainers, with no
    active maintainer concerns.
  * **Large Changes**: These include adding a new factor, removing an existing
    factor, or making substantial alterations to core principles. Large changes
    require sign-off from at least five maintainers, with no active maintainer
    concerns.
* **Version Control**: Medium and large changes will be made in a "next" branch
  within the version control system (e.g., Git), allowing the community to test
  and evaluate proposed modifications before they are finalized. This ensures
  traceability and the ability to easily review and revert changes if needed.

## Major Releases

Once the changes in the "next" branch have been tested and reviewed,
maintainers will review the set of changes and sign off with a supermajority on
"major releases" of the principles. This process moves the changes from the
"next" branch to the main branch, officially updating the manifesto. Major
releases will happen no more than once a year to ensure stability and provide
sufficient time for evaluation and community feedback.

## Updating Governance

All substantive changes in Governance require a supermajority agreement by the
maintainers.

## Brand

In its pre-foundation form, Heroku will retain control over the brand of the
project. The brand is inclusive of any associated logos, trademarks, and site
designs. The intent is to find a longer term home where this will all be
transferred to a foundation for community governance. The governance will be
updated to reflect when this change occurs.

## Code of Conduct

For code of conduct, we will follow the [Contributor
Covenant](https://www.contributor-covenant.org/). In case of violations of the
covenant, the following process will be followed:

1. **Initial Report**: Violations must be reported to the
   [maintainers](MAINTAINERS.md). Reports can be submitted anonymously or
   directly to a designated maintainer.
2. **Assessment**: Upon receiving a report, a team of three (3) maintainers
   will be selected to assess the situation and gather relevant information.
   This may involve interviewing the involved parties and any witnesses.
3. **Decision**: Based on the gathered information, maintainers will decide on
   the appropriate action. Actions may include issuing warnings, requiring a
   formal apology, removing members from roles, or banning individuals from
   participation.
4. **Notification**: The involved parties will be informed of the decision, and
   a record will be kept for future reference.
5. **Appeal**: The individual subject to disciplinary action has the right to
   appeal the decision. Appeals will be reviewed by a panel of maintainers not
   directly involved in the initial assessment.

Actions may vary depending on the severity of the infraction, and maintainers
will strive to apply consequences consistently and fairly.

## Definitions

#### Supermajority

Throughout these documents, "supermajority" means 66%+.
</file>

<file path="LICENSE">
Attribution 4.0 International

=======================================================================

Creative Commons Corporation ("Creative Commons") is not a law firm and
does not provide legal services or legal advice. Distribution of
Creative Commons public licenses does not create a lawyer-client or
other relationship. Creative Commons makes its licenses and related
information available on an "as-is" basis. Creative Commons gives no
warranties regarding its licenses, any material licensed under their
terms and conditions, or any related information. Creative Commons
disclaims all liability for damages resulting from their use to the
fullest extent possible.

Using Creative Commons Public Licenses

Creative Commons public licenses provide a standard set of terms and
conditions that creators and other rights holders may use to share
original works of authorship and other material subject to copyright
and certain other rights specified in the public license below. The
following considerations are for informational purposes only, are not
exhaustive, and do not form part of our licenses.

     Considerations for licensors: Our public licenses are
     intended for use by those authorized to give the public
     permission to use material in ways otherwise restricted by
     copyright and certain other rights. Our licenses are
     irrevocable. Licensors should read and understand the terms
     and conditions of the license they choose before applying it.
     Licensors should also secure all rights necessary before
     applying our licenses so that the public can reuse the
     material as expected. Licensors should clearly mark any
     material not subject to the license. This includes other CC-
     licensed material, or material used under an exception or
     limitation to copyright. More considerations for licensors:
	wiki.creativecommons.org/Considerations_for_licensors

     Considerations for the public: By using one of our public
     licenses, a licensor grants the public permission to use the
     licensed material under specified terms and conditions. If
     the licensor's permission is not necessary for any reason--for
     example, because of any applicable exception or limitation to
     copyright--then that use is not regulated by the license. Our
     licenses grant only permissions under copyright and certain
     other rights that a licensor has authority to grant. Use of
     the licensed material may still be restricted for other
     reasons, including because others have copyright or other
     rights in the material. A licensor may make special requests,
     such as asking that all changes be marked or described.
     Although not required by our licenses, you are encouraged to
     respect those requests where reasonable. More_considerations
     for the public:
	wiki.creativecommons.org/Considerations_for_licensees

=======================================================================

Creative Commons Attribution 4.0 International Public License

By exercising the Licensed Rights (defined below), You accept and agree
to be bound by the terms and conditions of this Creative Commons
Attribution 4.0 International Public License ("Public License"). To the
extent this Public License may be interpreted as a contract, You are
granted the Licensed Rights in consideration of Your acceptance of
these terms and conditions, and the Licensor grants You such rights in
consideration of benefits the Licensor receives from making the
Licensed Material available under these terms and conditions.


Section 1 -- Definitions.

  a. Adapted Material means material subject to Copyright and Similar
     Rights that is derived from or based upon the Licensed Material
     and in which the Licensed Material is translated, altered,
     arranged, transformed, or otherwise modified in a manner requiring
     permission under the Copyright and Similar Rights held by the
     Licensor. For purposes of this Public License, where the Licensed
     Material is a musical work, performance, or sound recording,
     Adapted Material is always produced where the Licensed Material is
     synched in timed relation with a moving image.

  b. Adapter's License means the license You apply to Your Copyright
     and Similar Rights in Your contributions to Adapted Material in
     accordance with the terms and conditions of this Public License.

  c. Copyright and Similar Rights means copyright and/or similar rights
     closely related to copyright including, without limitation,
     performance, broadcast, sound recording, and Sui Generis Database
     Rights, without regard to how the rights are labeled or
     categorized. For purposes of this Public License, the rights
     specified in Section 2(b)(1)-(2) are not Copyright and Similar
     Rights.

  d. Effective Technological Measures means those measures that, in the
     absence of proper authority, may not be circumvented under laws
     fulfilling obligations under Article 11 of the WIPO Copyright
     Treaty adopted on December 20, 1996, and/or similar international
     agreements.

  e. Exceptions and Limitations means fair use, fair dealing, and/or
     any other exception or limitation to Copyright and Similar Rights
     that applies to Your use of the Licensed Material.

  f. Licensed Material means the artistic or literary work, database,
     or other material to which the Licensor applied this Public
     License.

  g. Licensed Rights means the rights granted to You subject to the
     terms and conditions of this Public License, which are limited to
     all Copyright and Similar Rights that apply to Your use of the
     Licensed Material and that the Licensor has authority to license.

  h. Licensor means the individual(s) or entity(ies) granting rights
     under this Public License.

  i. Share means to provide material to the public by any means or
     process that requires permission under the Licensed Rights, such
     as reproduction, public display, public performance, distribution,
     dissemination, communication, or importation, and to make material
     available to the public including in ways that members of the
     public may access the material from a place and at a time
     individually chosen by them.

  j. Sui Generis Database Rights means rights other than copyright
     resulting from Directive 96/9/EC of the European Parliament and of
     the Council of 11 March 1996 on the legal protection of databases,
     as amended and/or succeeded, as well as other essentially
     equivalent rights anywhere in the world.

  k. You means the individual or entity exercising the Licensed Rights
     under this Public License. Your has a corresponding meaning.


Section 2 -- Scope.

  a. License grant.

       1. Subject to the terms and conditions of this Public License,
          the Licensor hereby grants You a worldwide, royalty-free,
          non-sublicensable, non-exclusive, irrevocable license to
          exercise the Licensed Rights in the Licensed Material to:

            a. reproduce and Share the Licensed Material, in whole or
               in part; and

            b. produce, reproduce, and Share Adapted Material.

       2. Exceptions and Limitations. For the avoidance of doubt, where
          Exceptions and Limitations apply to Your use, this Public
          License does not apply, and You do not need to comply with
          its terms and conditions.

       3. Term. The term of this Public License is specified in Section
          6(a).

       4. Media and formats; technical modifications allowed. The
          Licensor authorizes You to exercise the Licensed Rights in
          all media and formats whether now known or hereafter created,
          and to make technical modifications necessary to do so. The
          Licensor waives and/or agrees not to assert any right or
          authority to forbid You from making technical modifications
          necessary to exercise the Licensed Rights, including
          technical modifications necessary to circumvent Effective
          Technological Measures. For purposes of this Public License,
          simply making modifications authorized by this Section 2(a)
          (4) never produces Adapted Material.

       5. Downstream recipients.

            a. Offer from the Licensor -- Licensed Material. Every
               recipient of the Licensed Material automatically
               receives an offer from the Licensor to exercise the
               Licensed Rights under the terms and conditions of this
               Public License.

            b. No downstream restrictions. You may not offer or impose
               any additional or different terms or conditions on, or
               apply any Effective Technological Measures to, the
               Licensed Material if doing so restricts exercise of the
               Licensed Rights by any recipient of the Licensed
               Material.

       6. No endorsement. Nothing in this Public License constitutes or
          may be construed as permission to assert or imply that You
          are, or that Your use of the Licensed Material is, connected
          with, or sponsored, endorsed, or granted official status by,
          the Licensor or others designated to receive attribution as
          provided in Section 3(a)(1)(A)(i).

  b. Other rights.

       1. Moral rights, such as the right of integrity, are not
          licensed under this Public License, nor are publicity,
          privacy, and/or other similar personality rights; however, to
          the extent possible, the Licensor waives and/or agrees not to
          assert any such rights held by the Licensor to the limited
          extent necessary to allow You to exercise the Licensed
          Rights, but not otherwise.

       2. Patent and trademark rights are not licensed under this
          Public License.

       3. To the extent possible, the Licensor waives any right to
          collect royalties from You for the exercise of the Licensed
          Rights, whether directly or through a collecting society
          under any voluntary or waivable statutory or compulsory
          licensing scheme. In all other cases the Licensor expressly
          reserves any right to collect such royalties.


Section 3 -- License Conditions.

Your exercise of the Licensed Rights is expressly made subject to the
following conditions.

  a. Attribution.

       1. If You Share the Licensed Material (including in modified
          form), You must:

            a. retain the following if it is supplied by the Licensor
               with the Licensed Material:

                 i. identification of the creator(s) of the Licensed
                    Material and any others designated to receive
                    attribution, in any reasonable manner requested by
                    the Licensor (including by pseudonym if
                    designated);

                ii. a copyright notice;

               iii. a notice that refers to this Public License;

                iv. a notice that refers to the disclaimer of
                    warranties;

                 v. a URI or hyperlink to the Licensed Material to the
                    extent reasonably practicable;

            b. indicate if You modified the Licensed Material and
               retain an indication of any previous modifications; and

            c. indicate the Licensed Material is licensed under this
               Public License, and include the text of, or the URI or
               hyperlink to, this Public License.

       2. You may satisfy the conditions in Section 3(a)(1) in any
          reasonable manner based on the medium, means, and context in
          which You Share the Licensed Material. For example, it may be
          reasonable to satisfy the conditions by providing a URI or
          hyperlink to a resource that includes the required
          information.

       3. If requested by the Licensor, You must remove any of the
          information required by Section 3(a)(1)(A) to the extent
          reasonably practicable.

       4. If You Share Adapted Material You produce, the Adapter's
          License You apply must not prevent recipients of the Adapted
          Material from complying with this Public License.


Section 4 -- Sui Generis Database Rights.

Where the Licensed Rights include Sui Generis Database Rights that
apply to Your use of the Licensed Material:

  a. for the avoidance of doubt, Section 2(a)(1) grants You the right
     to extract, reuse, reproduce, and Share all or a substantial
     portion of the contents of the database;

  b. if You include all or a substantial portion of the database
     contents in a database in which You have Sui Generis Database
     Rights, then the database in which You have Sui Generis Database
     Rights (but not its individual contents) is Adapted Material; and

  c. You must comply with the conditions in Section 3(a) if You Share
     all or a substantial portion of the contents of the database.

For the avoidance of doubt, this Section 4 supplements and does not
replace Your obligations under this Public License where the Licensed
Rights include other Copyright and Similar Rights.


Section 5 -- Disclaimer of Warranties and Limitation of Liability.

  a. UNLESS OTHERWISE SEPARATELY UNDERTAKEN BY THE LICENSOR, TO THE
     EXTENT POSSIBLE, THE LICENSOR OFFERS THE LICENSED MATERIAL AS-IS
     AND AS-AVAILABLE, AND MAKES NO REPRESENTATIONS OR WARRANTIES OF
     ANY KIND CONCERNING THE LICENSED MATERIAL, WHETHER EXPRESS,
     IMPLIED, STATUTORY, OR OTHER. THIS INCLUDES, WITHOUT LIMITATION,
     WARRANTIES OF TITLE, MERCHANTABILITY, FITNESS FOR A PARTICULAR
     PURPOSE, NON-INFRINGEMENT, ABSENCE OF LATENT OR OTHER DEFECTS,
     ACCURACY, OR THE PRESENCE OR ABSENCE OF ERRORS, WHETHER OR NOT
     KNOWN OR DISCOVERABLE. WHERE DISCLAIMERS OF WARRANTIES ARE NOT
     ALLOWED IN FULL OR IN PART, THIS DISCLAIMER MAY NOT APPLY TO YOU.

  b. TO THE EXTENT POSSIBLE, IN NO EVENT WILL THE LICENSOR BE LIABLE
     TO YOU ON ANY LEGAL THEORY (INCLUDING, WITHOUT LIMITATION,
     NEGLIGENCE) OR OTHERWISE FOR ANY DIRECT, SPECIAL, INDIRECT,
     INCIDENTAL, CONSEQUENTIAL, PUNITIVE, EXEMPLARY, OR OTHER LOSSES,
     COSTS, EXPENSES, OR DAMAGES ARISING OUT OF THIS PUBLIC LICENSE OR
     USE OF THE LICENSED MATERIAL, EVEN IF THE LICENSOR HAS BEEN
     ADVISED OF THE POSSIBILITY OF SUCH LOSSES, COSTS, EXPENSES, OR
     DAMAGES. WHERE A LIMITATION OF LIABILITY IS NOT ALLOWED IN FULL OR
     IN PART, THIS LIMITATION MAY NOT APPLY TO YOU.

  c. The disclaimer of warranties and limitation of liability provided
     above shall be interpreted in a manner that, to the extent
     possible, most closely approximates an absolute disclaimer and
     waiver of all liability.


Section 6 -- Term and Termination.

  a. This Public License applies for the term of the Copyright and
     Similar Rights licensed here. However, if You fail to comply with
     this Public License, then Your rights under this Public License
     terminate automatically.

  b. Where Your right to use the Licensed Material has terminated under
     Section 6(a), it reinstates:

       1. automatically as of the date the violation is cured, provided
          it is cured within 30 days of Your discovery of the
          violation; or

       2. upon express reinstatement by the Licensor.

     For the avoidance of doubt, this Section 6(b) does not affect any
     right the Licensor may have to seek remedies for Your violations
     of this Public License.

  c. For the avoidance of doubt, the Licensor may also offer the
     Licensed Material under separate terms or conditions or stop
     distributing the Licensed Material at any time; however, doing so
     will not terminate this Public License.

  d. Sections 1, 5, 6, 7, and 8 survive termination of this Public
     License.


Section 7 -- Other Terms and Conditions.

  a. The Licensor shall not be bound by any additional or different
     terms or conditions communicated by You unless expressly agreed.

  b. Any arrangements, understandings, or agreements regarding the
     Licensed Material not stated herein are separate from and
     independent of the terms and conditions of this Public License.


Section 8 -- Interpretation.

  a. For the avoidance of doubt, this Public License does not, and
     shall not be interpreted to, reduce, limit, restrict, or impose
     conditions on any use of the Licensed Material that could lawfully
     be made without permission under this Public License.

  b. To the extent possible, if any provision of this Public License is
     deemed unenforceable, it shall be automatically reformed to the
     minimum extent necessary to make it enforceable. If the provision
     cannot be reformed, it shall be severed from this Public License
     without affecting the enforceability of the remaining terms and
     conditions.

  c. No term or condition of this Public License will be waived and no
     failure to comply consented to unless expressly agreed to by the
     Licensor.

  d. Nothing in this Public License constitutes or may be interpreted
     as a limitation upon, or waiver of, any privileges and immunities
     that apply to the Licensor or You, including from the legal
     processes of any jurisdiction or authority.


=======================================================================

Creative Commons is not a party to its public
licenses. Notwithstanding, Creative Commons may elect to apply one of
its public licenses to material it publishes and in those instances
will be considered the “Licensor.” The text of the Creative Commons
public licenses is dedicated to the public domain under the CC0 Public
Domain Dedication. Except for the limited purpose of indicating that
material is shared under a Creative Commons public license or as
otherwise permitted by the Creative Commons policies published at
creativecommons.org/policies, Creative Commons does not authorize the
use of the trademark "Creative Commons" or any other trademark or logo
of Creative Commons without its prior written consent including,
without limitation, in connection with any unauthorized modifications
to any of its public licenses or any other arrangements,
understandings, or agreements concerning use of licensed material. For
the avoidance of doubt, this paragraph does not form part of the
public licenses.

Creative Commons may be contacted at creativecommons.org.
</file>

<file path="MAINTAINERS.md">
# Twelve Factor Maintainers

## Active Maintainers

| Name            | GitHub Username                                    | Discord Username  |
| --------------- | -------------------------------------------------- | ----------------- |
| Vish Abrams     | [@vishvananda](https://github.com/vishvananda)     | vishvananda       |
| Evan Anderson   | [@evankanderson](https://github.com/evankanderson) | evan_92162        |
| Brian Hammons   | [@brianhammons](https://github.com/brianhammons)   | brianhammons.     |
| Grace Jansen    | [@GraceJansen](https://github.com/GraceJansen)     | gracejansen_70738 |
| Yehuda Katz     | [@wycats](https://github.com/wycats)               | wycats            |
| Joe Kutner      | [@jkutner](https://github.com/jkutner)             | codefinger007     |
| Terence Lee     | [@hone](https://github.com/hone)                   | hone              |
| James Ward      | [@jamesward](https://github.com/jamesward)         | _jamesward        |
| Brett Weaver    | [@weavenet](https://github.com/weavenet)           | weavenet          |

## Emeritus Maintainers

| Name            | GitHub Username                                    |
| --------------- | -------------------------------------------------- |
| Gail Frederick  | [@gailfrederick](https://github.com/gailfrederick) |
| Steren Giannini | [@steren](https://github.com/steren)               |
</file>

<file path="README.md">
[![CC BY 4.0][cc-by-shield]][cc-by]
[![Discord](https://img.shields.io/discord/1296917489615110174?label=discord&logo=discord&logoColor=#5865F2)](https://discord.gg/9HFMDMt95z)
[![Google
Group](https://img.shields.io/badge/mailing_list-blue)](https://groups.google.com/g/twelve-factor)

# The Twelve-Factor Manifesto

This is the repository for the text of the updated version of the twelve-factor
manifesto, which will ultimately replace the one hosted at
[12factor.net](https://12factor.net). The text is located in the [content
directory](content). As noted in the [governance document](GOVERNANCE.md),
changes will occur in the
[next](https://github.com/twelve-factor/twelve-factor/tree/next) branch until
the maintainers agree that the current round of updates is complete.

## Vision

The details of our vision for the update can be found in [VISION.md](VISION.md)

## How to Participate

Information on participating is in [CONTRIBUTING.md](CONTRIBUTING.md)

## Additional Information

- **Governance**: Read more about the project's governance and decision-making
  process in [GOVERNANCE.md](GOVERNANCE.md).
- **Code of Conduct**: We use the [Contributor
  Covenant](https://www.contributor-covenant.org/) and expect all contributors
  to follow it.
- **Questions?** If you have any questions or need help, feel free to join the
  discussion on GitHub or reach out to a [maintainer](MAINTAINERS.md).
- **Prior Art**:
  - [https://www.oreilly.com/library/view/beyond-the-twelve-factor/9781492042631/](https://www.oreilly.com/library/view/beyond-the-twelve-factor/9781492042631/)  
  - Nginx amendments (deleted from their site, but present in [https://slidrio-decks.global.ssl.fastly.net/1020/original.pdf](https://slidrio-decks.global.ssl.fastly.net/1020/original.pdf))
  - [https://www.cncf.io/blog/2022/04/28/twelve-factor-app-anno-2022/](https://www.cncf.io/blog/2022/04/28/twelve-factor-app-anno-2022/)
  - [https://lab.abilian.com/Tech/Cloud/The%2012%20Factor%20App/](https://lab.abilian.com/Tech/Cloud/The%2012%20Factor%20App/)
  - [https://www.ibm.com/blog/7-missing-factors-from-12-factor-applications/](https://www.ibm.com/blog/7-missing-factors-from-12-factor-applications/)

## Update Frequently Asked Questions

- [What is this?](UPDATE_FAQ.md#what-is-this)
- [Why now?](UPDATE_FAQ.md#why-now)
- [Why isn't \[my favorite software development principle\] a factor?](UPDATE_FAQ.md#why-isnt-my-favorite-software-development-principle-a-factor)
- [Who’s helping and why?](UPDATE_FAQ.md#whos-helping-and-why)
- [Will there always be twelve factors?](UPDATE_FAQ.md#will-there-always-be-twelve-factors)
- [What’s not changing?](UPDATE_FAQ.md#whats-not-changing)
- [What is changing?](UPDATE_FAQ.md#what-is-changing)
- [Are you just updating the examples?](UPDATE_FAQ.md#are-you-just-updating-the-examples)

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
</file>

<file path="UPDATE_FAQ.md">
# Twelve-Factor Update FAQ

## What is this?

We aim to refine and modernize the twelve-factor manifesto. The manifesto must
be **refined**, shedding outdated concepts and focusing on core application
design for cloud deployment. Then the manifesto can be **modernized** for the
current generation of cloud applications, providing best practices for
observability, security, configuration, etc. These changes will make it easier
to deploy, manage, and migrate twelve-factor applications across multiple
compute runtimes and environments (local, testing, staging, production).

The original manifesto is a foundational work that continues to be relevant
today. We plan to make respectful updates to the original, sticking closely to
its spirit and goals. We will also make sure that the original text remains
available as part of the new website.

We intend to work mindfully on the changes in this repository, **beginning by
separating the principles from the examples and updating the examples to
reflect modern practices**. We will start with the simplifying constraint of
stateless request-based apps that made the initial model so popular before
expanding to include other modern workload types.

The examples and guidelines serve as a [**living
document**](https://whatwg.org/faq#living-standard). As best practices evolve,
the maintainer group will adjust the recommendations to ensure the timeless
concepts remain applicable to ecosystem changes. Refer to [the governance
document](GOVERNANCE.md#change-management-process) for the process we will use
to evolve the factors.

## Why now?

Over a decade ago, Heroku co-founder Adam Wiggins published the [Twelve-Factor
App methodology](https://blog.heroku.com/twelve-factor-apps) as a way to codify
the [best practices for writing SaaS
applications](https://en.wikipedia.org/wiki/Twelve-Factor_App_methodology). In
that time, cloud-native has become the default for all new applications, and
technologies like Kubernetes are widespread. Best-practices for software have
evolved, and we believe that Twelve-Factor also needs to evolve.

But we also believe that the core ideas in twelve-factor are timeless and are
more relevant than ever. “The Twelve-Factor App” started a revolution based on
this idea: if there is a clean interface contract between applications and
platforms, application developers can build portable, scalable applications
across multiple compute runtimes and environments (local, testing, staging,
production).

This was decidedly *not* the state of affairs in 2011, when “The Twelve-Factor
App” was first written. By outlining a contract between applications and
platforms, that began to change. Over the years, much of the contract defined
by twelve-factor has become conventional wisdom. At the same time, applications
have become more sophisticated, and the ecosystem’s best practices have drifted
away from the details outlined in the original manifesto.

The goal of this refresh is to revitalize and modernize the contract between
applications and platforms, retaining a strong focus on the perspective of the
application codebase.

## Why isn't \[my favorite software development principle\] a factor?

When selecting factors, we hold closely to the principles laid out in our
[vision](VISION.md). Twelve-factor isn't intended to be a collection of
everything you need to think about when building an application. It
specifically focuses on the interfaces between the application and the
platform. This means that a number of software development principles (DRY,
YAGNI, KISS, etc.) will never be explicit factors.

Additionally, the factors are intended to be agnostic to the programming
language which applications are built in – the factors should apply
consistently whether the application is written in Java, bash, or Haskell.

Finally, some factors may simply be too early to include. Twelve-factor strikes
a balance between capturing established practices and promoting practices that
are not yet widely used. There is no hard-and-fast rule for how established a
practice must be, so inclusion is a judgment call by the maintainers.

## Who’s helping and why?

Twelve-Factor is a community effort, led by application, platform, and
framework developers that understand the value of common principles and shared
understanding of the contract between an application and its underlying
platform. The current list of maintainers can be found in
[MAINTAINERS.md](MAINTAINERS.md).

## Will there always be twelve factors?

The original manifesto had twelve factors. We intend to keep the number of
factors the same. In addition to helping with name-recognition, we view this as
a valuable constraint to keep the manifesto focused and clear.

## What’s not changing?

The introductory framing, which is a great guiding philosophy for the project,
and is just as true today as it was in 2012.

The scope and purpose of the factors will also remain the same. They are
**application** best practices that define a contract between the application
code and a deployment platform.

## What is changing?

The original document contains examples and guidelines that have drifted away
from ecosystem best-practices. We plan to start by modernizing the examples and
guidelines to bring them up to date with current practices. We also plan to
make changes to the structure of the factors so that we can continue to evolve
them moving forward.

## Are you just updating the examples?

One of the key values of the original manifesto was driving consensus across
development communities and driving changes that made it easier to build
applications. We intend for the new version to do the same. We hope to
encourage collaboration across communities to solve thorny application problems
like authentication and service-to-service communication.
</file>

<file path="VISION.md">
# Twelve-Factor Vision

The twelve-factor manifesto defines **ideal practices for app development** to
minimize fragility, foster maintainable growth, reduce collaboration friction,
and prevent software erosion. It provides a shared vocabulary for discussing
these practices and offers clear, actionable recommendations.

The essence of Twelve-Factor is a **clear contract between an application and
its execution platform.**

Twelve-Factor focuses on reducing cognitive load for the application developer
and offers prescriptive practices to limit the responsibilities and therefore
concerns of the application. These practices are most powerful when they are
implemented into application frameworks and cloud platforms, enabling
developers to **operationalize for free**.

The manifesto includes three types of content:

* **Factors:** the twelve most important principles for applications and
  platforms to follow.
* **Examples:** descriptions that show how the principles apply in different
  scenarios.
* **Guidelines:** concrete requirements for complying with the factors.

The content adheres to four basic tenets:

1. **Selective**: deliberately constrained, trading flexibility for focus and
   shared understanding.
2. **Specific:** detailed enough to be used by developers, platforms, and
   frameworks.
3. **Clear:** easy to understand and apply for all audiences.
4. **Relevant:** timeless concepts and up-to-date examples.

Following Twelve-Factor implies a loss of control at the application layer, but
**it rewards this sacrifice with substantial value.** This value comes from the
factors' emphasis on development practices that improve operability,
**addressing day-two concerns on day one**. As a result, a twelve-factor
application is secure, configurable, observable, predictable, and updatable.
These attributes enable it to scale with changing demand, integrate easily into
larger systems, and remain portable across platforms.
</file>

</files>
