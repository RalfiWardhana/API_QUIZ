package database

import (
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func NewDabataseConn() *gorm.DB {
	dsn := "root:N#@98wrft45@tcp(127.0.0.1:3306)/golang?charset=utf8mb4&parseTime=True&loc=Local"
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		panic(err)
	}
	return db
}
