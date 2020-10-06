Providers can be passed down to descendent modules in two ways: 
    either implicitly through inheritance, 
    or explicitly via the providers argument within a module block.

## Implicit Provider Inheritance ##

For convenience in simple configurations, a child module automatically inherits default (un-aliased) provider configurations from its parent. This means that explicit provider blocks appear only in the root module, and downstream modules can simply declare resources for that provider and have them automatically associated with the root provider configurations.