package usecase

import (
	"course/internal/domain"
	"strconv"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type QuestionUsecase struct {
	db *gorm.DB
}

func NewQuestionUsecase(db *gorm.DB) *QuestionUsecase {
	return &QuestionUsecase{
		db: db,
	}
}

func (quesUsecase QuestionUsecase) AddQuestion(c *gin.Context) {
	paramID := c.Param("id")
	id, err := strconv.Atoi(paramID)
	var exercise domain.Exercise
	err = quesUsecase.db.Where("id = ?", id).Take(&exercise).Error
	if err != nil {
		c.JSON(404, map[string]string{
			"message": "exercise not found",
		})
		return
	}

	type QusetionRequest struct {
		Body          string
		OptionA       string
		OptionB       string
		OptionC       string
		OptionD       string
		CorrectAnswer string
	}

	var questionRequest QusetionRequest
	if err := c.ShouldBind(&questionRequest); err != nil {
		c.JSON(400, map[string]string{
			"message": "invalid input",
		})
		return
	}

	if questionRequest.Body == "" {
		c.JSON(400, map[string]string{
			"message": "body required",
		})
		return
	}
	if questionRequest.OptionA == "" {
		c.JSON(400, map[string]string{
			"message": "option A required",
		})
		return
	}
	if questionRequest.OptionB == "" {
		c.JSON(400, map[string]string{
			"message": "option B required",
		})
		return
	}
	if questionRequest.OptionC == "" {
		c.JSON(400, map[string]string{
			"message": "option C required",
		})
		return
	}
	if questionRequest.OptionD == "" {
		c.JSON(400, map[string]string{
			"message": "option D required",
		})
		return
	}
	if questionRequest.CorrectAnswer == "" {
		c.JSON(400, map[string]string{
			"message": "correct answer required",
		})
		return
	}
	userID := int(c.Request.Context().Value("user_id").(float64))
	Question := domain.NewQuestion(id, questionRequest.Body, questionRequest.OptionA, questionRequest.OptionB, questionRequest.OptionC, questionRequest.OptionD, questionRequest.CorrectAnswer, userID)
	if err := quesUsecase.db.Create(Question).Error; err != nil {
		c.JSON(500, map[string]string{
			"message": "cannot create question",
		})
		return
	}
	c.JSON(201, map[string]string{
		"message": "Success to add",
	})
}
