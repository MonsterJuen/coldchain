package main

import (
	"coldchain/backend/controllers"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	// 配置CORS
	config := cors.DefaultConfig()
	config.AllowOrigins = []string{"http://123.57.22.188", "http://localhost:5173"} // 允许服务器IP和本地开发环境
	config.AllowMethods = []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"}
	config.AllowHeaders = []string{"Origin", "Content-Type", "Accept", "Authorization"}
	r.Use(cors.New(config))

	// 路由组
	api := r.Group("/api")
	{
		// 货物相关路由
		goods := api.Group("/goods")
		{
			goods.GET("/list", controllers.GetGoodsList)
			goods.POST("/create", controllers.CreateGoods)
			goods.PUT("/update/:id", controllers.UpdateGoods)
			goods.DELETE("/delete/:id", controllers.DeleteGoods)
			goods.POST("/out", controllers.OutGoods)
		}
	}

	r.Run(":8090")
}
