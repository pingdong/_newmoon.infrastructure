It's common to see in a pipeline that PowerShell scripts and HCL scripts work tightly and passing variables around through pipeline Yaml files. It is understandable as the evolution of each platform is in a fast pace, and the latency of supports by its provider of terraform. The limitation generates low readability, therefore increases the maintenance efforts. After a few years, the portability is compromised unnoticedly. Luckily the world changed, even the limits are still applied, it's eased significantly. My previous role gave me a chance to think how to improve it. But unfortunately, I haven’t had time to land it. 

I designed and built the repository of a common scenario to provide a workable solution.

The core service is an Azure Function App with required Storage Account and App Service Plan. An Azure App Configuration is used to share service configuration across all resources. An Azure Keyvault is used to protect the connection string of the App Configuration and uses the Keyvault reference to expose the connection string to the Function App. An App Insights is linked to the Function App.

In integration testing, it’s unnecessary to involve indirect resource to the testing resources. Therefore, Azure Keyvault is not necessary. But App Configuration is still valuable to share settings across different services and multiple integration tests of the same service. The App Insights is also needed to persist the testing logs for debugging purpose. Even the resource is destroyed after testing for cost saving. Recycling testing resources could pollute the testing itself. Another different is putting shared App Configuration and App Insight in a separate Resource Group reduces the maintain job. Cleaning testing resource is as simple as deleting the Resource Group that contains the testing resource. Appending suffix to the testing resources helps isolating multiple tests and increase productivity.

Base on the lessons I learned from terraform, concept and practice of general development. I built this repository to demonstrate a workable approach to answer the above challenge.

To archive the goal, a few high-level design consideration is worth to mention.

1. Single script for all environments
Script should be created on service level, not on environment level. Creating a script contains all resources of the service for all environments. A single script for all environments removes the burden of sync works and minimize the work of syncing between different environments and the potential difference between infrastructure code and actual resources. You may argue that. The fact of lacking native conditional expression support, the single script is a challenge.  Stay tune, you can find a solution in this repository.

2. Self-autonomous
The script should be self-autonomous and depends on input variables as less as possible. If you follow this principle, you can develop and test infrastructure scripts locally without waiting in the building queue. Developing infrastructure codes without pipeline increases not only the productivity but also confidence. In long term operation, the readability of pipeline and infrastructure scripts are improved either. Another benefit may be neglected. Decoupling pipeline and infrastructure also guarantee the portability of infrastructure codes. 

3. Fan-in and Fan-out
The main tf script should be fan-out and fan-in for module scripts. The main tf scripts focus on aggregating resources and passing required details arounds.

