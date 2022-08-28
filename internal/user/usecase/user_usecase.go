package usecase

import (
	"course/internal/domain"
	"errors"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v4"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type UserUsecase struct {
	db *gorm.DB
}

func NewUserUsecase(db *gorm.DB) *UserUsecase {
	return &UserUsecase{
		db: db,
	}
}

func (uu UserUsecase) Register(c *gin.Context) {
	type RegisterRequest struct {
		Name     string
		Email    string
		Password string
	}

	var registerRequest RegisterRequest
	if err := c.ShouldBind(&registerRequest); err != nil {
		c.JSON(400, map[string]string{
			"message": "invalid input",
		})
		return
	}

	if registerRequest.Name == "" {
		c.JSON(400, map[string]string{
			"message": "name required",
		})
		return
	}
	if registerRequest.Email == "" {
		c.JSON(400, map[string]string{
			"message": "email required",
		})
		return
	}
	if registerRequest.Password == "" {
		c.JSON(400, map[string]string{
			"message": "Password required",
		})
		return
	}
	if len(registerRequest.Password) < 6 {
		c.JSON(400, map[string]string{
			"message": "Password must more than 6 character",
		})
		return
	}

	user := domain.NewUser(registerRequest.Name, registerRequest.Email, registerRequest.Password)
	if err := uu.db.Create(user).Error; err != nil {
		c.JSON(500, map[string]string{
			"message": "cannot create user",
		})
		return
	}
	token, err := user.GenerateToken()
	if err != nil {
		c.JSON(500, map[string]string{
			"message": "cannot create token",
		})
		return
	}
	c.JSON(201, map[string]string{
		"token": token,
	})
}

func (uu UserUsecase) DecryptJWT(token string) (map[string]interface{}, error) {
	parsedToken, err := jwt.Parse(token, func(t *jwt.Token) (interface{}, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, errors.New("auth invalid")
		}
		return domain.PrivateKey, nil
	})
	if err != nil {
		return map[string]interface{}{}, err
	}

	if !parsedToken.Valid {
		return map[string]interface{}{}, err
	}

	return parsedToken.Claims.(jwt.MapClaims), nil
}

func (uu UserUsecase) Login(c *gin.Context) {
	var userRequest domain.User
	err := c.ShouldBind(&userRequest)
	if err != nil {
		c.JSON(400, gin.H{
			"message": "invalid input",
		})
		return
	}
	if userRequest.Email == "" || userRequest.Password == "" {
		c.JSON(400, gin.H{
			"message": "email/password required",
		})
		return
	}

	var user domain.User
	err = uu.db.Where("email = ?", userRequest.Email).Take(&user).Error
	if err != nil || user.ID == 0 {
		c.JSON(400, gin.H{
			"message": "wrong email/password",
		})
		return
	}

	err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(userRequest.Password))
	if err != nil {
		c.JSON(400, gin.H{
			"message": "wrong email/password",
		})
		return
	}
	token, _ := user.GenerateToken()
	c.JSON(200, gin.H{
		"token": token,
	})
}
