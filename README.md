## Open source license metadata retrieval with OSI
__Author:__ Oliver Keyes<br/>
__License:__ [MIT](http://opensource.org/licenses/MIT)<br/>
__Status:__ Stable

![downloads](http://cranlogs.r-pkg.org/badges/grand-total/osi)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/osi)](https://cran.r-project.org/package=osi)

`osi` is a simple package to connect to the Open Source Initiative's API from R. It contains functions for:

1. Retrieving metadata about open source licenses;
2. Extracting values from said metadata;
3. Retrieving the actual plaintext versions of licenses covered by the API.

For more information, see the [accompanying vignette](https://cran.r-project.org/web/packages/osi/vignettes/license.html)! 

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

Installation
======

For the most recent version, on CRAN:

    install.packages("osi")
    
For the development version:

    library(devtools)
    devtools::install_github("ironholds/osi")
    
Dependencies
======
* R. Doy.
* [httr](https://cran.r-project.org/package=httr) and its dependencies.
