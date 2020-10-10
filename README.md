It is common to see in a pipeline that PowerShell scripts and HCL scripts work tightly and passing variables around. It is understandable as the evolution of each platform itself in a fast pace, and the latency of support by the provider in terraform. The limitation generates low readability, therefore increases the maintenance efforts. After a few years, the portability is compromised. Luckily, the world changed, even the limit is still applied, it's eased significantly. 

The repository provides a workable solution to answer the common challenge.

The core service is an Azure Function App with required Storage Account and App Service Plan. An Azure App Configuration is used to share service configuration across all resources. An Azure Keyvault is used to protect the connection string of the App Configuration and uses the Keyvault reference to expose the connection string to the Function App. An App Insights is linked to the Function App. This setting is not much difference for DEV/SIT/UAT/PROD environment.

In integration testing, it’s unnecessary to involve indirect resource. Therefore, Azure Keyvault is not necessary. But App Configuration is still valuable to share settings across different services and multiple integration tests of the same service. The App Insights is also needed to persist the testing logs for debugging purpose. Even the resource is destroyed after testing for cost saving. Recycling testing resources could pollute the testing itself. Another different is putting shared App Configuration and App Insight in a separate Resource Group reduces the maintain job. Cleaning testing resource is as simple as deleting the Resource Group that contains the testing resource. Appending suffix to the testing resources helps isolating multiple tests and increase productivity.

Base on the lessons I learned from terraform, concept and practice of general development. I built this repository to demonstrate a workable approach to answer the above challenge.

More details in [Wiki](https://github.com/pingdong/newmoon.infrastructure/wiki)
