# PAF_k8s

## Proposition pour aujourd'hui

1) [Introduction à Kubernetes](#introduction-à-kubernetes)

2) [Lancement d'un cluster avec Rancher sur deux VMs](#lancement-cluster)

3) Prise en main des UI de Rancher et de Kubernetes

4) [Déploiement de services](#exemples-en-ligne)

        <http://kubernetesbyexample.com/>

5) [Test avec Katacoda pour ceux qui veulent voir d'autres choses](#katacoda)

        <https://www.katacoda.com/courses/kubernetes>

6) [Pour aller plus loin](#pour-aller-plus-loin)

7) [Questions investiguées lors du DOJO](#questions-investiguées-lors-du-dojo)

## Introduction à kubernetes

### Video de présentation
Cette vidéo est à mon avis très bien faite pour introduire ce qu'est kubernetes:

<https://youtu.be/NChhdOZV4sY>

### Intro rapide (en anglais)
https://kubernetes.io/docs/concepts/ 
Kubernetes is a container orchestration system for managing workloads and services that facilitates automation. This kind of tool is necessary for production as it allows to handle the creation, communication and monitoring of containers.

#### Kubernetes components

##### Master components
The master components provide the cluster’s control plane. It performs automatically various tasks to maintain the cluster in the desired state: restarting containers, scaling the number of replicas of a given application etc. The Kubernetes **Control Plane** consists of a collection of processes running on the cluster: 
-	*Kube-apiserver*,  it exposes the Kubernetes API, it is the front-end for the Kubernetes control plane
-	*Kube-controller-manager*, it includes different controllers that all run in a single process: node controller, replication controller, endpoints controller, service account and token controller,
-	*Cloud-controller-manager*, if need it runs controllers that interact with the underlying cloud providers.
-	*Kube-scheduller*, it selects a node for the newly created pods.

The **etcd**, is a distributed key-value store used for configuration management, service discovery and coordinating distributed work. The etcd is not included in the control plane.

##### Worker components
-	*Kubelet*, which communicates with the Kubernetes Master
-	*Kube-proxy*, a network proxy that reflects Kubernetes networking services on each node.

The kubectl command-line interface is used to communicate with the cluster’s Kubernetes master. The master can be replicated for availability and redundancy.

See the following Figure for an illustration of the different component of a Kubernetes cluster.
![](https://blog.octo.com/wp-content/uploads/2017/01/architecturenormal-1024x843.png)

Taken from <https://blog.octo.com/en/how-does-it-work-kubernetes-episode-1-kubernetes-general-architecture/>


#### Kubernetes objects

**Pod** <https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/>
A pod is the smallest and simplest unit among Kubernetes object, it represents a running process on the cluster. A pod encapsulates one or several containers (they will share the same context, as if running on the same host), storage resources, a unique network IP, and various options that govern how the container should run.
A pod by itself is not stable, if its host node is shut down, or if the scheduling operation fails, the pod is deleted. Thus, it is convenient to use a higher-level of abstraction, a **Controller**, which will manage pods, handling replication, rollout and self-healing capabilities. They are different kind of Controller: *Deployment*, *StatefulSet* and *Daemon Set*.

**Service** <https://kubernetes.io/docs/concepts/services-networking/service>
Pods are mortal, they are created and when they die, other can be created but they are never resurrected. Thus, the IP address of a Pod is not stable; it will last until the Pod died. To assure a stable frontend for pods that provide a functionality to others there exist Services.
A service is an abstraction defining a set of pods and a policy to access them. A Label Selector determines the set of targeted Pods. A service can expose multiple ports to target port. They are four types of Services:
-	*ClusterIP*: it is the default, it exposes the service on a cluster-internal IP, the service will be only reachable from within the cluster.
-	*NodePort*: Exposes the service on each Node’s IP at a static port. A ClusterIp service is automatically created to route the NodePort services. The NodePort service, can be contacted from outside the cluster with <NodeIP>:<NodePort>.
-	*LoadBalancer*: It exposes the service externally using a cloud provider’s load balancer. NodePort and ClusterIp services, to which the external load balancer will route, are automatically created. There exist solutions for bare metal cluster without cloud provider (https://metallb.universe.tf/tutorial/)
-	*ExternalName*: Maps the services to the contents of the externalName field (it should be a canonical DNS name), by returning a CNAME record with its value. (https://kubernetes.io/docs/concepts/services-networking/service/#externalname)

-	*ExternalIP*, we can specify the external IP of a service, for example for load balancer or ClusterIP that we would like to access from outside the Kubernetes cluster. This option takes an IP address from a predefined pool of external IP addresses routed to the cluster’s nodes. These external IP addresses are not managed by Kubernetes; they are the responsibility of the cluster administrator.

**Volume** <https://kubernetes.io/docs/concepts/storage/volumes/>
Container’s volumes are ephemeral, if it crashed, kubelet will restart it, but its files will be lost. Kubenetes Volume allows to have a persistence of volumes and also to share volume between containers. Kubernetes volumes have an explicit lifetime, the same as the Pod that encloses it, it outlives any Container that run inside the pod. Kubernetes supports a vast variety of volumes’ types, and a Pod can use any number of them simultaneously.

TODO explain PV and PVC

**Namespace** <https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/>
Kubernetes starts with three initial namespaces: default, kube-system and kube-public. Names of resources have to be unique within a namespace, but not across namespaces. Namespaces purpose is for environments shared by multiple teams. We did not use thoroughly this component, and limit ourselves to the default namespace.


#### Kubernetes networking
There different level of networking with Kubernetes. First, any Pod can communicate with any other Pod of the same cluster without the use of network address translation (NAT). Indeed Kubernetes assigns to each Pod an IP address that is routable within the cluster.
However, network policies can be defined to prevent a Pod from communicating with another.

## Lancement cluster de deux VMs

Installation de Kubernetes avec l'aide de RKE (Rancher Kubernetes Engine)

<https://itnext.io/setup-a-basic-kubernetes-cluster-with-ease-using-rke-a5f3cc44f26f>


### Liens utiles trouvés sur le net

- <https://kubernetes.io/fr/docs/tutorials/kubernetes-basics/>

- <https://www.weave.works/blog/kubernetes-beginners-guide/>

- <https://kubernetes.io/docs/concepts/configuration/overview/>

- <https://kubernetes.io/docs/setup/best-practices/>

- <https://www.replex.io/blog/kubernetes-in-production-readiness-checklist-and-best-practices-for-resource-management>

## Exemples en ligne

<http://kubernetesbyexample.com>

## Katacoda

Plateforme pour pratiquer en ligne gratuitement, environement Minikube

<https://www.katacoda.com/courses/kubernetes>

Vous y trouverez également pas mal de cas pratiques pour Docker et plein d'autres choses


## Points à creuser pour cas d'usage à Thales Services

- La gestion du Proxy

	<https://rancher.com/docs/rancher/v2.x/en/installation/single-node/proxy/>

- La gestion des utilisateurs

	* <https://kubernetes.io/docs/reference/access-authn-authz/authentication/>
	* <https://kubernetes.io/docs/tasks/administer-cluster/namespaces/>
	* <https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/>

- Les différentes API existantes

	* Python : <https://github.com/kubernetes-client/python>
	* Java : <https://github.com/kubernetes-client/java>
	* Javascript, Perl and others in progress on the same repo
	* Description officielle de l'API <https://kubernetes.io/docs/concepts/overview/kubernetes-api/>


## Questions investiguées lors du DOJO

A remplir
