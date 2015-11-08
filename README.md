## Basic Infinite Scroll with UITableView

This is a tutorial to setting up a basic infinite scroll on UITableView.

#### What does inifite scroll mean?

Here is the basic idea in few points:

* Suppose you have to load a table view (by pulling data from some data source such a REST API)
* Since, the datasource might have 100s and 1000s of results, you don't want to be loading all of them in a single go
* What you do instead is to load few results (say 50) to begin with
* You load additional results only when user gets to the bottom and needs to see more results.

#### Tutorial:


### Development/Testing environment

* Operating System: OS X El Capitan v10.11
* Xcode v7.0/Swift 2.0
* iOS v9.0
* Devices
 * iPhone 6 Simulator
