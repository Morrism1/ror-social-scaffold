# Scaffold for social media app with Ruby on Rails

## About The Project

> This project is based on social media fundamentals and already included the MVC for users, posts comments, posts  likes and dislikes we added functionality for Friendships, Unit and integration tests.

![Screenshot 2020-11-10 161437](https://user-images.githubusercontent.com/46853433/98685380-f3967d00-236f-11eb-99da-88d31f2cd3d6.png)

## Entity Relation Digram

![erd_ror](https://user-images.githubusercontent.com/46853433/97510902-6d9d2e00-198e-11eb-9ec8-1bdd423f855d.png)

## Built With

* Ruby v2.7.1
* Ruby on Rails v6.0.3
* Rspec
* Capybara
* Rubocop
* Windows WSL(Ubuntu 20.04)
* Github-Actions
* VsCode

## Live Demo

[Live Demo](https://fathomless-island-24503.herokuapp.com/)

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.7.1
Rails: 6.0.3
Postgres: >=9.5

### Setup

Instal gems with:

```bash
bundle install
```

Setup database with:

```bash
   rails db:create
   rails db:migrate
```

### Github Actions

To make sure the linters' checks using Github Actions work properly, you should follow the next steps:

1. On your recently forked repo, enable the GitHub Actions in the Actions tab.
2. Create the `feature/branch` and push.
3. Start working on your milestone as usual.
4. Open a PR from the `feature/branch` when your work is done.

### Usage

Start server with:

```bash
    rails server
```

Open `http://localhost:3000/` in your browser.

### Run tests

```bash
    rpsec --format documentation
```

> Tests will be added by Microverse students. There are no tests for initial features in order to make sure that students write all tests from scratch.

### Deployment

TBA

## Author

👤 **Maurice MURANGWA**

* Github: [@Morrism1](https://github.com/Morrism1)

* Twitter: [@MorrisMontana0](https://twitter.com/MurangwaMorris)

* Linkedin: [Maurice Murangwa](https://www.linkedin.com/in/mauricemurangwa/)  

## 🤝 Contributing

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

* [Microverse](https://www.microverse.org/)
* [ror-social-scaffold](https://github.com/microverseinc/ror-social-scaffold)
* [Heroku](https://www.heroku.com/)
* [The Best readme Template](https://github.com/othneildrew/Best-README-Template)

## 📝 License

This project is [MIT](https://opensource.org/licenses/MIT) licensed.
