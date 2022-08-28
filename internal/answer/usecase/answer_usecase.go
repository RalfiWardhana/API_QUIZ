package usecase

import (
	"course/internal/domain"
	"strconv"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type AnswerUsecase struct {
	db *gorm.DB
}

func NewAnswerUsecase(db *gorm.DB) *AnswerUsecase {
	return &AnswerUsecase{
		db: db,
	}
}

func (ansUsecase AnswerUsecase) AddAnswer(c *gin.Context) {
	exerciseID := c.Param("id")
	questionID := c.Param("questionId")
	exerciseId, err := strconv.Atoi(exerciseID)
	questionId, err := strconv.Atoi(questionID)
	var exercise domain.Exercise
	err = ansUsecase.db.Where("id = ?", exerciseId).Take(&exercise).Error
	if err != nil {
		c.JSON(404, map[string]string{
			"message": "exercise not found",
		})
		return
	}

	var question domain.Question
	err = ansUsecase.db.Where("id = ?", questionId).Take(&question).Error
	if err != nil {
		c.JSON(404, map[string]string{
			"message": "question not found",
		})
		return
	}

	type AnswersRequest struct {
		Answer string
	}

	var AnswerRequest AnswersRequest
	if err := c.ShouldBind(&AnswerRequest); err != nil {
		c.JSON(400, map[string]string{
			"message": "invalid input",
		})
		return
	}

	if AnswerRequest.Answer == "" {
		c.JSON(400, map[string]string{
			"message": "answer required",
		})
		return
	}

	userID := int(c.Request.Context().Value("user_id").(float64))
	Answer := domain.NewAnswer(exerciseId, questionId, userID, AnswerRequest.Answer)
	if err := ansUsecase.db.Create(Answer).Error; err != nil {
		c.JSON(500, map[string]string{
			"message": "cannot create Answer",
		})
		return
	}
	c.JSON(201, map[string]string{
		"message": "Success to add",
	})
}
