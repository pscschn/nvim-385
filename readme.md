<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![Docker][docker-shield]][docker-url]
[![Nvim][nvim-shield]][nvim-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">


<h3 align="center">🚧 UNDER CONSTRUCTION 🚧</h3>

  <p align="center">
    This is my nvim configuration. Don't expect this to work yet !
    <br />

</div>


<!-- ABOUT THE PROJECT -->
## About The Project

This will be a configuration with strong focus on modularity and customizability. No existing configuration out there fully meets my expectation. I'd like to customize a configuration, but I don't want to invest time navigating through interwoven lua files, researching countless plugin names, to know what each is doing until I have the confidence to actually change something.
So, I've decided to create my own project, which will solve these problems for me.

### Solution Strategy

The idea is to standardize a structure for better comprehention of the config without knowing plugin specifics. 
Plugins will be grouped as lua modules based on their effect on nvim. 
The source directory will be readable similar to the settings of a gui based code editor. 

Even without knowing the structure, you should be guided to your desired target setting and intuitively discover something like "code completion" under a more general descriptor like "Intellisense" just by looking at the directory structure (for example).
It should not be necessary to rummage through countless files or to research any documentation to get an idea of what plugin xz does. 

> There is already a [template structure](./template/readme.md) provided within this repo that depicts this idea  more concretely.





<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/pscschn/nvim-385.svg?style=for-the-badge
[contributors-url]: https://github.com/pscschn/nvim-385/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/pscschn/nvim-385.svg?style=for-the-badge
[forks-url]: https://github.com/pscschn/nvim-385/network/members
[stars-shield]: https://img.shields.io/github/stars/pscschn/nvim-385.svg?style=for-the-badge
[stars-url]: https://github.com/pscschn/nvim-385/stargazers
[issues-shield]: https://img.shields.io/github/issues/pscschn/nvim-385.svg?style=for-the-badge
[issues-url]: https://github.com/pscschn/nvim-385/issues
[license-shield]: https://img.shields.io/github/license/pscschn/nvim-385.svg?style=for-the-badge
[license-url]: https://github.com/pscschn/nvim-385/blob/master/LICENSE.txt
[docker-shield]: https://img.shields.io/badge/Docker-1D63ED?style=for-the-badge&logo=docker&logoColor=white
[docker-url]: https://www.docker.com/
[nvim-shield]: https://img.shields.io/badge/NeoVim-%23092E20.svg?&style=for-the-badge&logo=neovim&logoColor=white
[nvim-url]: https://neovim.io/