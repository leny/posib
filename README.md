# ![posib.](https://raw.github.com/krkn/posib/master/lib/client/styles/img/logo.png)

Simple in-place editing CMS

* * *

## Documentation
_(Coming soon)_

## Examples
_(Coming soon)_

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Lint your code using [Grunt](http://gruntjs.com/).

### Code organization

All the code is stored under the `/src` folder. The code is written in **Coffeescript**.

### Setup development environment

Setting up a development environment to contribute (or study) **posib.** is very simple : you only need to install [Vagrant](http://www.vagrantup.com).

In your console, browse to the **posib.** root and enter :

    $> vagrant up && vagrant ssh

After the install, you will be connected by ssh inside the virtual machine.  
You only need to enter :

    $> grunt work

It will launch `grunt watch` and `supervisor` tasks, compiling and restarting server during your development.

Open a browser to [192.168.1.222](http://192.168.1.222) to preview the **posib.** development website.  
The files for the *dev* website are stored under the `sample` folder.

If you use [SublimeText](http://www.sublimetext.com), a `sublime-project` file is included.

## Release History

> **posib.** already exists before this project, as a personnal 2011 PHP project (non open-sourced). This repository is the reborn of the idea, using all the power and advantages of node.js, and will be released as version 1.0 on npm.

* **2011-11-25**: Starting the original `PHP` project.
* **2012-01-12**: Release version 1.0
* **2012-06-26**: Release version 2.0
* **2013-09-01**: Last version of 1.x branch : 1.8.14
* **2013-09-01**: Last version of 2.x branch : 2.9.5
* **2014-02-02**: Starting `node.js` project

### Milestones planning

* [x] **0.1**
    * [x] Public core
    * [x] Short Bricks
    * [x] Rich Bricks
    * [x] Image Bricks (simple)
    * [x] Page informations
    * [x] Content caching
* [ ] **0.2**
    * [ ] Admin core
    * [ ] Modals core
    * [ ] Short Bricks
    * [ ] Rich Bricks
    * [ ] Image Bricks (simple)
    * [ ] Page informations
    * [ ] --- first push on **npm**
* [ ] **0.3**
    * [ ] Form Bricks
* [ ] **0.4**
    * [ ] Map Bricks
* [ ] **0.5**
    * [ ] Image Bricks (gallery)
* [ ] **0.6**
    * [ ] Code Bricks
* [ ] **0.7**
    * [ ] Audio Bricks
    * [ ] Video Bricks
* [ ] **0.8**
    * [ ] Time Bricks
* [ ] **0.9**
    * [ ] List Bricks
* [ ] **0.10**
    * [ ] Table Bricks
* [ ] **1.0**
    * [ ] Documentation for developers
    * [ ] Documentation for users
    * [ ] Presentation website
    * [ ] --- release on **npm**

## License
Copyright (c) 2014 krkn  
Licensed under the MIT license.
