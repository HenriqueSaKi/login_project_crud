
## Login Project - API :iphone:

### Running via command line
For run Spring Boot via command line. You must have maven installed and correctly added maven to your environment variable. </br>
**Ps:** If you don't have maven installed, check this [link](https://mkyong.com/maven/how-to-install-maven-in-windows/) to help you to install and add to your environment variables properly.

If you already have maven installed, navigate to the root of the project via command line and execute the command:

```
mvn spring-boot:run
```

### API resources


| Method | HTTP Request | Endpoint |
|--|:--:|:--|
| **`isAvailable`** | **GET** | `http://localhost:8080/login_project/isAvailable` |
| **`register`** | **POST** | `http://localhost:8080/login_project/register` |
| **`login`** | **POST** | `http://localhost:8080/login_project/login` |
| **`user`** | **POST** | `http://localhost:8080/login_project/user` |
| **`update`** | **POST** | `http://localhost:8080/login_project/update` |
| **`delete`** | **POST** | `http://localhost:8080/login_project/delete` |



### isAvailable
##### Description </br>
Check is the service is available.

##### Response
| Http Status | Response Body |
|:--:|:--|
| `200` | The service is available! |

### register
##### Description </br>
Register a user into a SQL Server database by first name, last name, e-mail and password.

##### Body
```
{
	"firstName":"Henrique",
	"lastName":"Kisaki" ,
	"email":"example@example.com",
	"password":"password123"
}
```

##### Response 
| Http Status | Response Body |
|:--:|:--|
| `200` |  |
| `400` | Failed request. |
| `409` | Email already registered. |


### login
##### Description </br>
Check user information.

##### Body 
```
{
	"email":"example@example.com",
	"password":"password123"
}
```

##### Response
| Http Status | Response Body |
|:--:|:--|
| `200` | Accepted! |
| `409` | There's no account associated with this email. Try another email address or create a new account. |
| `409` | Invalid Credentials! |


### user
##### Description </br>

Return user data by e-mail and password.

##### Body
```
{
	"email":"example@example.com",
	"password":"password123"
}
```

##### Response
| Http Status | Response Body |
|:--:|:--|
| `200` |  |

#### update
##### Description </br>

Update user data by email.

##### Body
```
{
	"firstName":"Henrique",
	"lastName":"Kisaki" ,
	"email":"example@example.com",
	"password":"password123"
}
```

##### Response
| Http Status | Response Body |
|:--:|:--|
| `200` | Updated successfully! |


#### delete
##### Description </br>

Delete user by e-mail.

##### Body
```
{
	"email":"teste2@teste.com"
}
```

##### Response
| Http Status | Response Body |
|:--:|:--|
| `200` | Account deleted successfully! |
