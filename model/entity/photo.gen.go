// Code generated by gorm.io/gen. DO NOT EDIT.
// Code generated by gorm.io/gen. DO NOT EDIT.
// Code generated by gorm.io/gen. DO NOT EDIT.

package entity

import (
	"time"
)

const TableNamePhoto = "photo"

// Photo mapped from table <photo>
type Photo struct {
	ID          int32      `gorm:"column:id;type:int;primaryKey;autoIncrement:true" json:"id"`
	CreateTime  time.Time  `gorm:"column:create_time;not null;index:photo_create_time,priority:1" json:"create_time"`
	UpdateTime  *time.Time `gorm:"column:update_time" json:"update_time"`
	Description string     `gorm:"column:description;type:varchar(255);not null" json:"description"`
	Location    string     `gorm:"column:location;type:varchar(255);not null" json:"location"`
	Name        string     `gorm:"column:name;type:varchar(255);not null" json:"name"`
	TakeTime    *time.Time `gorm:"column:take_time" json:"take_time"`
	Team        string     `gorm:"column:team;type:varchar(255);not null;index:photo_team,priority:1" json:"team"`
	Thumbnail   string     `gorm:"column:thumbnail;type:varchar(1023);not null" json:"thumbnail"`
	URL         string     `gorm:"column:url;type:varchar(1023);not null" json:"url"`
	Likes       int64      `gorm:"column:likes;type:bigint;not null" json:"likes"`
}

// TableName Photo's table name
func (*Photo) TableName() string {
	return TableNamePhoto
}
