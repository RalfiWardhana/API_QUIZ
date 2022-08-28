package main

import (
	answerUc "course/internal/answer/usecase"
	"course/internal/database"
	"course/internal/exercise/usecase"
	"course/internal/middleware"
	questionUc "course/internal/question/usecase"
	userUc "course/internal/user/usecase"
	"fmt"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	db := database.NewDabataseConn()
	exerciseUcs := usecase.NewExerciseUsecase(db)
	questionUcs := questionUc.NewQuestionUsecase(db)
	answerUcs := answerUc.NewAnswerUsecase(db)
	fmt.Println(answerUcs)
	userUcs := userUc.NewUserUsecase(db)
	r.GET("/hello", func(c *gin.Context) {
		c.JSON(200, map[string]string{
			"message": "hello world",
		})
	})
	// exercise
	r.POST("/exercises", middleware.WithAuthentication(userUcs), exerciseUcs.AddExercise)
	r.GET("/exercises/:id", middleware.WithAuthentication(userUcs), exerciseUcs.GetExercise)
	r.GET("/exercises/:id/scores", middleware.WithAuthentication(userUcs), exerciseUcs.CalculateScore)

	//question
	r.POST("exercises/:id/questions", middleware.WithAuthentication(userUcs), questionUcs.AddQuestion)

	//answer
	r.POST("/exercises/:id/questions/:questionId/answer", middleware.WithAuthentication(userUcs), answerUcs.AddAnswer)

	// user
	r.POST("/register", userUcs.Register)
	r.POST("/login", userUcs.Login)
	r.Run(":1234")
}
