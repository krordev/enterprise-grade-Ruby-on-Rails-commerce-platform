Workarea Commerce Platform
================================================================================
[![CI Status]]
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v1.4%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)

[Workarea] is an enterprise-grade commerce platform written in [Ruby on Rails](https://rubyonrails.org). It uses [MongoDB](https://www.mongodb.com), [Elasticsearch](https://www.elastic.co/products/elasticsearch), and [Redis](https://redis.io). Workarea also uses a whole lot of gems you can see in [our gemspec].



Features
--------------------------------------------------------------------------------
Workarea combines commerce, content, search, and insights into a unified platform to enable merchants to move faster and work smarter. Out-of-the-box features include:

**Storefront**
* Mobile-first frontend
* Localization support
* First-class SEO
* Built-in analytics
* Cart and checkout
* Customer accounts
* Discounts
* Basic taxes
* Shipping services

**Content**
* Responsive CMS
* Asset management
* Localized content
* Intelligent merchandising
* Content-based navigation

**Search**
* Product search
* Search-driven categories
* Filtering and sorting
* Search merchandising
* Results tuning
* Advanced reporting

**Insights**
* Robust dashboards
* Sales reports
* Trending reports
* Search reports
* Advanced insights

**Admin**
* Site planning and automation
* Workflows for common tasks
* Inline insights
* Search-first administration
* Commenting
* Audit logs for changes


Demo
--------------------------------------------------------------------------------
You can run a demo version of Workarea after installing [Docker](https://www.docker.com/) by running the following command in your terminal

**If you are using MacOS or Windows, this will require you to increase Docker's memory allocation to at least 4GB**. Go to your Docker preferences, select the  advanced tab, and adjust the memory slider.

Once complete, you can view the Workarea Storefront at <http://localhost:3000> and the Workarea Admin at <http://localhost:3000/admin>. The seed data provides an admin user with an email/password of `user@workarea.com/w0rkArea!`.

See the [README](demo/README.md) in the [`demo`] directory for more information.


Getting Started
--------------------------------------------------------------------------------
We'd suggest checking out our introductory overview article on Workarea to wrap your head around the technology. [Read the Workarea developer overview article].

Then try following [our guide on creating a new Workarea Rails app]

If you have any problems, reach out on our [public Slack]. We're happy to help!

**Watch the Quickstart Video:** <https://vimeo.com/370085475>


Plugins
--------------------------------------------------------------------------------
Workarea extends functionality with a library of plugins. These plugins add everything from additional content blocks, to wish lists, to payment gateway integrations and more. Here are some of the most popular plugins:

| Plugin | Description |
| --- | --- |
| [API](https://github.com/workarea-commerce/workarea-api) | Provides APIs for storefront and admin |
| [Blog](https://github.com/workarea-commerce/workarea-blog) | Integrated blogging |
| [Reviews](https://github.com/workarea-commerce/workarea-reviews) | Adds product reviews |
| [Google Analytics](https://github.com/workarea-commerce/workarea-google-analytics) | Integrates GA with Workarea's analytics |
| [Paypal](https://github.com/workarea-commerce/workarea-paypal) | Adds Paypal checkout |
| [Wish Lists](https://github.com/workarea-commerce/workarea-wish-lists) | Adds customer wish lists |
| [Sitemaps](https://github.com/workarea-commerce/workarea-sitemaps) | Autogenerating sitemaps |
| [Share](https://github.com/workarea-commerce/workarea-share) | Adds page sharing via social media or email |
| [Package Products](https://github.com/workarea-commerce/workarea-package-products) | Allows displaying products as a group in browse and details pages |
| [Gift Cards](https://github.com/workarea-commerce/workarea-gift-cards) | Adds Workarea-native digital gift cards |

To see a full list of open-source plugins, check out the [Workarea Github organization]. More plugins like B2B functionality, order management, and running multiple sites are available through the [Workarea Commerce Cloud].


Extension
--------------------------------------------------------------------------------
Workarea is meant to be extended and customized to fit merchant needs. It's built as a collection of [Rails Engines](https://guides.rubyonrails.org/engines.html) so the [Rails guides on customizing engines](https://guides.rubyonrails.org/engines.html#improving-engine-functionality) apply. Workarea also includes the [Rails Decorators] to provide a easy and familiar path for Rails developers to customize Ruby classes. To read more, check out [our documentation on extension].


Deploying
--------------------------------------------------------------------------------
Workarea is fairly complex application to host, we recommend our [Commerce Cloud] hosting.

If you'd like to host on your own, we have some documentation to help:


Sites Running Workarea
--------------------------------------------------------------------------------
[The Bouqs](https://bouqs.com)  
[Sanrio](https://www.sanrio.com)  
[BHLDN](https://www.bhldn.com)  
[Reformation](https://www.thereformation.com)  
[Woodcraft](https://www.woodcraft.com)  
[Lonely Planet](https://shop.lonelyplanet.com)  
[Paragon Sports](https://www.paragonsports.com)  
[Costume Super Center](https://www.costumesupercenter.com)  
and many more!

