# Carbon Knight

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

  <h3 align="center">Carbon Knight</h3>

  <p align="center">
    This is the front end repository for the Carbon Knight application.  Within this application a user is able input travel data and see what their carbon footprint is over time.
    <br />
    <br />
    <!-- for adding a demo video
    <a href="Add our video link here">View Demo</a>  · -->
    ·
    <a href="https://github.com/Carbon-Knight/carbon-knight-back-end/issues">Report Bug</a>
    ·
    <a href="https://github.com/Carbon-Knight/carbon-knight-back-end/issues">Request Feature</a>
  </p>
</p>




<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Features](#features)
  * [Adding a New User Car](#adding-a-new-user-car)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Configuration](#configuration)
  * [Testing](#testing)
* [Contributing](#contributing)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)




<!-- ABOUT THE PROJECT -->
## About The Project

There are three repositories for this project.  A Microservice which connects with the [Cloverly API](https://www.cloverly.com/) in order to return carbon footprint data, and the Backend which compiles this data and returns the requested data to the Frontend.

To view all the repositories associated with Carbon Knight, please visit [Carbon Knight](https://github.com/Carbon-Knight)




### Built With

* [Ruby](https://github.com/ruby/ruby)
* [GraphQL](https://graphql.org/)
* [Sinatra](http://sinatrarb.com/)
* [TravisCI](https://www.travis-ci.com/)
* [Heroku](https://www.heroku.com/)


## Features

### Adding a New User Car 
1. Click on Carbon Calculator in the Navigation Bar
![Navigate to the Carbon Calculator](app/assets/images/dashboard/click_carbon_footprint_calculator.png)
    - Image left for future reference when adding actual images (after styling is done)
1. Click 'Add a Car' link to navigate to the new car form 
1. Complete the required fields for a new car (Make, Model, Year, Fuel efficiency), Fuel type 
1. Click 'Add Vehicle' once all fields have been completed (an error message will display otherwise)
   - You will be redirected back to the carbon footprint calculator 
1. Added car will be visible within the car selection drop down 


<!-- GETTING STARTED -->
## Getting Started
1. Clone this repo `git clone https://github.com/Carbon-Knight/Front-End.git`
2. Enter the directory it was cloned into `cd Front-End`
3. Run `bundle install` to install gems and dependencies
4. Run `bundle exec rails db:{create,migrate}` to set up the database
5. Run `bundle exec figaro install`
  * Add `GOOGLE_CLIENT_ID: <ID HERE>` to the `config/application.yml` file created
    by figaro
  * Add `GOOGLE_CLIENT_SECRET: <SECRET HERE>` to the above file


### Configuration

1. ```git clone git@github.com:Carbon-Knight/carbon-knight-back-end.git```
2. ```cd carbon-knight-back-end```
3. ```bundle install```


### Testing

[RSpec](https://rspec.info/) was used for the testing of this project.

Carbon Knight Frontend has been fully tested. To view the test coverage;

Once inside your terminal within the Carbon Knight Backend directory run the following command.
```
open coverage
```

This will open up a folder with an index.html file. Clicking on this file will show you a list of all lines of code within this project, and whether they have been tested or not.

Additionally, running ```bundle exec rspec``` will show you the quick summary of the test coverage in this application.

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/Carbon-Knight/carbon-knight-back-end/issues) for a list of proposed features, known issues, and project extensions.


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make this community such an amazing and fun place to learn, grow, and create! Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch ```git checkout -b feature/NewGreatFeature```
3. Commit your Changes ```git commit -m 'Add some NewGreatFeature'```
4. Push to the Branch ```git push origin feature/NewGreatFeature```
5. Open a new Pull Request!


<!-- CONTACT -->
## Contact

Curtis Bartell &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/curtis-bartell/) - [GitHub](https://github.com/c-bartell)

Jonathan Wilson - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/jonathan--wilson/) - [GitHub](https://github.com/Jonathan-M-Wilson)

Carson Jardine &nbsp;&nbsp; - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/carson-jardine/) - [GitHub](https://github.com/carson-jardine)

Eugene Theriault - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/eugene-theriault/) - [GitHub](https://github.com/ETBassist)

Roberto Basulto &nbsp;- [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/roberto-basulto/) - [GitHub](https://github.com/Eternal-Flame085)

James Belta &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/james-belta/) - [GitHub](https://github.com/JBelta)

Joshua Carey &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/carey-joshua/) - [GitHub](https://github.com/jdcarey128)

Kiera Allen &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/kieraallen/) - [GitHub](https://github.com/KieraAllen)

Sean Steel &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/sean-steel/) - [GitHub](https://github.com/s-steel)



Project Link: [Carbon Knight](https://github.com/Carbon-Knight)



<!-- ACKNOWLEDGEMENTS -->
<!-- Add resources that were used to help create this project here -->




<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/Carbon-Knight/carbon-knight-back-end
[contributors-url]: https://github.com/Carbon-Knight/carbon-knight-back-end/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Carbon-Knight/carbon-knight-back-end
[forks-url]: https://github.com/Carbon-Knight/carbon-knight-back-end/network/members
[stars-shield]: https://img.shields.io/github/stars/Carbon-Knight/carbon-knight-back-end
[stars-url]: https://github.com/Carbon-Knight/carbon-knight-back-end/stargazers
[issues-shield]: https://img.shields.io/github/issues/Carbon-Knight/carbon-knight-back-end
[issues-url]: https://github.com/Carbon-Knight/carbon-knight-back-end/issues
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
