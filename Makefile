MASTER := $(shell helm show chart master | awk '/^name:/ {print $$2}')
APISIX := $(shell helm show chart apisix | awk '/^name:/ {print $$2}')
AGENT := $(shell helm show chart agent | awk '/^name:/ {print $$2}')

.DEFAULT_GOAL := package

package:
	helm dependency update master
	helm dependency update agent
	helm package master
	helm push $(MASTER)-*.tgz  oci://registry-1.docker.io/no8ge
	rm -f $(MASTER)-*.tgz

	helm package apisix
	helm push $(APISIX)-*.tgz  oci://registry-1.docker.io/no8ge
	rm -f $(APISIX)-*.tgz

	helm package agent
	helm push $(AGENT)-*.tgz  oci://registry-1.docker.io/no8ge
	rm -f $(AGENT)-*.tgz

.PHONY: build package