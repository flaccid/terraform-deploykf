
<!-- markdownlint-disable -->
# terraform-deploykf
<!-- markdownlint-restore -->

<!--

  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **

-->

Terraform module for deploying deployKF (Kubeflow distribution).

---
>
> It's 100% Open Source and licensed under the [APACHE2](LICENSE).
>




## Introduction

This terraform module is a work in progress. It's intent to provide the plumbing requirements for deployKF and provision it end-to-end for different use cases.



## Usage

Currently a fully automated e2e deployment is not yet possible, however generally the steps are:

1. Call the module in your terraform state, e.g.:

```
module "deploy-kf" {
  source = "git::https://github.com/flaccid/terraform-deploykf"

  app_of_apps_values  = file("app-of-apps-values.yaml")
  argocd_helm_values  = <<EOF
configs:
  params:
    server.insecure: true

server:
  ingress:
    enabled: true
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt-production
      ingress.kubernetes.io/ssl-redirect: 'true'
      nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    ingressClassName: nginx
    hosts:
      - argocd.mydomain.com
    tls:
      - hosts:
          - argocd.mydomain.com
        secretName: argocd-mydomain-com-tls
EOF
  install_app_of_apps = true
}
```
Populate `app-of-apps-values.yaml` with the values you need per your use case and environment.

2. Sync the argocd apps per https://www.deploykf.org/guides/getting-started/
3. Profit

### Argo CD UI

Login with the default username (`admin`) and password retrieved using:

```
echo $(kubectl -n argocd get secret/argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d)
``` 

### Kubeflow UI

TBA

### Upstream Documentation

https://www.kubeflow.org/docs/started/installing-kubeflow/#packaged-distributions-of-kubeflow

#### deployKF

https://www.deploykf.org/guides/getting-started/

##### Pertinent links for this implementation

- https://github.com/deployKF/deployKF/tree/main/argocd-plugin
- https://www.deploykf.org/guides/tools/external-mysql/
- https://www.deploykf.org/guides/tools/external-object-store/
- https://www.deploykf.org/guides/platform/deploykf-gateway/
- https://www.deploykf.org/reference/deploykf-values/
- https://www.deploykf.org/guides/getting-started/#default-login-credentials
- https://www.kubeflow.org/docs/components/central-dash/access/

### Testing

Populate any required variables in `test/terraform.tfvars`
```
cd test
export KUBE_CONFIG_PATH=~/.kube/config
terraform init
terraform apply
```








## ✨ Contributing

This project is under active development, and we encourage contributions from our community. 
Many thanks to our outstanding contributors:

<a href="https://github.com/flaccid/terraform-deploykf/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=flaccid/terraform-deploykf&max=24" />
</a>

### 🐛 Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/flaccid/terraform-deploykf/issues) to report any bugs or file feature requests.

### 💻 Developing

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```

## Trademarks

All other trademarks referenced herein are the property of their respective owners.
---
Copyright © 2023-2024 Chris Fordham


<!-- markdownlint-disable -->

<!-- markdownlint-restore -->