# Running PeopleSoft Elasticsearch on Kubernetes #

This repo contains the presentation and supporting files for "Running PeopleSoft Elasticsearch on Kubernetes" given at psadmin.conf [psadmin.conf](https://psadmin.io/conference/) on March 7th, 2018.

Here's an overview of what's included in the repo, along with some descriptions.

```
├── LICENSE.md
├── README.md
├── demo
│   ├── image (contains the files necessary for building the Elasticsearch container image)
│   ├── manifests (kubernetes manifests for deploying Elasticsearch)
├── presentation
│   └── pses-kubernetes.pdf (presentation in pdf format)
└── terraform (terraform manifests for building out a Kubernetes cluster on Azure AKS)
```

## Additional Resources ##

* Kubernetes
    * Cloud Hosted Kubernetes
        * [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/)
        * [Azure Container Service - Microsoft Azure](https://azure.microsoft.com/en-us/services/container-service/)
        * [Container Engine - Oracle Cloud Infrastructure](https://cloud.oracle.com/containers)
        * [Elastic Container Service - AWS](https://aws.amazon.com/eks/)
    * Self Hosted Kubernetes
        * [Rancher](https://rancher.com/)
        * [OpenShift](https://www.openshift.com/)
        * [Vanilla Kubernetes](https://kubernetes.io/docs/setup/)
* Container Init Systems
    * [ContainerPilot](https://www.joyent.com/containerpilot)
    * [tini](https://github.com/krallin/tini)
    * [s6-overlay](https://github.com/just-containers/s6-overlay)
    * [dumb-init](https://github.com/Yelp/dumb-init)
* Self hosted Docker Registries
    * [VMware Harbor](https://vmware.github.io/harbor/)
    * [Portus](http://port.us.org/)
    * [Sonatype Nexus](https://www.sonatype.com/docker)
    * [GitLab Container Registry](https://docs.gitlab.com/ee/user/project/container_registry.html)
    * [Artifactory](https://jfrog.com/integration/docker-registry/)
* Ingress
    * [kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx/tree/master)
    * [Træfik](https://traefik.io/)
    * [Kubernetes - Træfik](https://docs.traefik.io/user-guide/kubernetes/)
    * [HAProxy](https://www.haproxy.com/)
    * [F5Networks/k8s-bigip-ctlr](https://github.com/F5Networks/k8s-bigip-ctlr)
* Elasticsearch on Kubernetes
    * [pires/kubernetes-elasticsearch-cluster](https://github.com/pires/kubernetes-elasticsearch-cluster)
    * [pires/docker-elasticsearch-kubernetes](https://github.com/pires/docker-elasticsearch-kubernetes)
    * [fabric8io/elasticsearch-cloud-kubernetes](https://github.com/fabric8io/elasticsearch-cloud-kubernetes)
* Additional Components & Tooling
    * [Cerebro](https://github.com/lmenezes/cerebro)
    * [Clair](https://github.com/coreos/clair)
    * [Prometheus](https://prometheus.io/)
    * [Grafana](https://grafana.com/)
    * [Ark](https://github.com/heptio/ark)
    * [Helm](https://www.helm.sh/)
    * [Stern](https://github.com/wercker/stern)
* Miscellaneous
    * [CNCF Cloud Native Interactive Landscape](https://landscape.cncf.io/)
