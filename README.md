# OpenPing

OpenPing is a versatile Rails API application designed to support a variety of backend services. It offers essential features for managing and authenticating users.

## Table of Contents

- [OpenPing](#openping)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Background Jobs](#background-jobs)
  - [API Endpoints](#api-endpoints)
    - [User Registration](#user-registration)
    - [User Sign-In](#user-sign-in)
    - [Sites Management](#sites-management)
    - [Authentication](#authentication)
  - [Running Tests](#running-tests)
  - [Environment Setup](#environment-setup)
  - [Contributing](#contributing)
  - [License](#license)

## Installation

To get started with OpenPing, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/openping.git
   cd openping
   ```

2. **Install dependencies:**

   Ensure you have Ruby and Bundler installed, then run:

   ```bash
   bundle install
   ```

3. **Set up the database:**

   Configure your database settings in `config/database.yml`, then run:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Set up credentials:**

   Edit your credentials file to include necessary secrets:

   ```bash
   rails credentials:edit
   ```

5. **Start the server:**

   Run the Rails server:

   ```bash
   rails server
   ```

## Usage

Once the server is running, you can interact with the API using tools like Postman or curl. The base URL for local development is `http://localhost:3000`.

### Background Jobs

OpenPing uses [GoodJob](https://github.com/bensheldon/good_job) for background job processing. GoodJob is configured to handle Active Job tasks, such as pinging sites at specified intervals. Ensure that the GoodJob worker is running to process these jobs. You can start the GoodJob worker with:

```bash
bundle exec good_job start
```

## API Endpoints

### User Registration

- **Endpoint:** `POST /api/v1/users`
- **Description:** Register a new user.
- **Request Body:**
  ```json
  {
    "user": {
      "email": "user@example.com",
      "password": "password"
    }
  }
  ```

### User Sign-In

- **Endpoint:** `POST /api/v1/sessions`
- **Description:** Sign in an existing user.
- **Request Body:**
  ```json
  {
    "email": "user@example.com",
    "password": "password"
  }
  ```

### Sites Management

- **Endpoint:** `GET /api/v1/sites`
  - **Description:** Retrieve a list of sites for the authenticated user.
  - **Response:** Array of site objects.

- **Endpoint:** `GET /api/v1/sites/:id`
  - **Description:** Retrieve a specific site by ID.
  - **Response:** Site object.

- **Endpoint:** `POST /api/v1/sites`
  - **Description:** Create a new site.
  - **Request Body:**
    ```json
    {
      "site": {
        "url": "http://example.com",
        "frequency": 10,
        "is_active": true
      }
    }
    ```

- **Endpoint:** `PATCH /api/v1/sites/:id`
  - **Description:** Update an existing site.
  - **Request Body:**
    ```json
    {
      "site": {
        "url": "http://newexample.com"
      }
    }
    ```

- **Endpoint:** `DELETE /api/v1/sites/:id`
  - **Description:** Delete a site by ID.

### Authentication

All endpoints require authentication. Include a valid JWT token in the `Authorization` header of your requests. The token can be obtained by signing in a user via the `/api/v1/sessions` endpoint.

## Running Tests

To run the test suite, execute:

```bash
bundle exec rspec
```

## Environment Setup

OpenPing uses environment variables and credentials for configuration. Ensure you have the following set up:

- **Database URL:** Set in `config/database.yml` or via environment variables.
- **Secret Key Base:** Managed via Rails credentials.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes with clear messages.
4. Push your branch and open a pull request.

## License

This project is licensed under the GNU General Public License v3.0. You are free to use, modify, and distribute this software under the terms of the GPL. For more details, see the [LICENSE](LICENSE) file.

The GPL license ensures that this project remains free and open-source, allowing anyone to contribute and benefit from its development.
