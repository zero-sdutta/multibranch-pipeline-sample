# multibranch-pipeline-sample

This Origin-Perf is inspired part from main branch i.e. sample setup of multi-branch pipeline as instructed by Darin Pope and other part from CloudBees Internal performance testing tool/framework.

It leverages the webhook based triggers to inject jobs at scale to JaaS Controllers.
The job definition consist of two stages i.e. build and publish where build fetches and runs a standalone java program from Mock Load Builder to mimic build load.
The load generation script injecting git commits floods the system with numerous branches having incremental parallel runs, therefore there also exists a cleanup script to purge all of it together.

~ CloudBees Performance Team
