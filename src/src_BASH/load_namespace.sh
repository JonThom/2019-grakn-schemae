#!/bin/bash
# https://dev.grakn.ai/docs/running-grakn/console
# TODO: Take arguments

grakn server start
grakn --keyspace hypermod --file $path_schema
