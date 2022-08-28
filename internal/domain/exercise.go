package domain

import "time"

type Exercise struct {
	ID          int
	Title       string
	Description string
	Questions   []Question
}

type Question struct {
	ID            int
	ExerciseID    int
	Body          string
	OptionA       string
	OptionB       string
	OptionC       string
	OptionD       string
	CorrectAnswer string
	Score         int
	CreatorID     int
	CreatedAt     time.Time
	UpdatedAt     time.Time
}

type Answer struct {
	ID         int
	ExerciseID int
	QuestionID int
	UserID     int
	Answer     string
	CreatedAt  time.Time
	UpdatedAt  time.Time
}

func NewExercise(title, desc string) *Exercise {
	return &Exercise{
		Title:       title,
		Description: desc,
	}
}

func NewQuestion(id int, body, optionA, optionB, optionC, optionD, correctAnswer string, userId int) *Question {
	return &Question{
		ExerciseID:    id,
		Body:          body,
		OptionA:       optionA,
		OptionB:       optionB,
		OptionC:       optionC,
		OptionD:       optionD,
		CorrectAnswer: correctAnswer,
		CreatorID:     userId,
	}
}

func NewAnswer(exerciseId, questionId, userId int, answer string) *Answer {
	return &Answer{
		ExerciseID: exerciseId,
		QuestionID: questionId,
		UserID:     userId,
		Answer:     answer,
	}
}
