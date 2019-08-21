---
title: Translate JavaScript Content
excerpt: Translate text within JavaScript templates and modules using the I18n.t() method provided by i18n-js (bundled with Workarea).
---

# Translate JavaScript Content

Translate text within JavaScript [templates](javascript-templates.html) and [modules](javascript-modules.html) using the `I18n.t()` method provided by [i18n-js](https://github.com/fnando/i18n-js) (bundled with Workarea).

The library provides access to the translations in `config/locales`, the same locale files used for [localization of static text in Ruby code](translate-or-customize-static-content.html).

workarea-storefront/app/assets/javascripts/workarea/storefront/templates/log\_out\_link.jst.ejs:

```
<span> (<a href="<%= WORKAREA.routes.storefront.logoutPath() %>" data-analytics="{'event':'logout', 'domEvent':'click'}" ><%= I18n.t('workarea.storefront.users.logout') %></a>)</span>
```
