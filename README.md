# Mood-Example

> `情绪记录` 样例工程  
> 这是一个使用Flutter实践的项目，主要目的是学习、实践。  
> 注意：由于是学习实践项目，所以重点在于学习，许多业务逻辑并不符合现实。  
  
## 🎉 开发环境

```
[√] Flutter (Channel stable, 2.8.0, on Microsoft Windows  
    [Version 10.0.22000.376], locale zh-CN)  
[√] Android toolchain - develop for Android devices (Android  
    SDK version 31.0.0)  
[√] Android Studio (version 2020.3)  
[√] VS Code (version 1.63.2)  
```

## 📑 项目结构

```
├── android                       # Android工程文件 
├── assets                        # 静态资源文件
├── build                         # 编译或运行后产物
├── ios                           # IOS工程文件
├── lib                           # 工程相关文件(主要编码)
│   ├── common                    # 公共相关
│   │   └── utils.dart            # 工具
│   ├── db                        # 数据存储相关
│   │   ├── database              # sqflite数据表配置
│   │   ├── db.dart               # sqflite数据库相关
│   │   └── preferences_db.dart   # shared_preferences数据相关
│   ├── models                    # 数据模型
│   ├── services                  # 数据服务
│   ├── view_models               # 业务逻辑
│   ├── views                     # 视图
│   ├── widgets                   # 组件相关
│   ├── app_theme.dart            # 主题
│   ├── application.dart          # 主应用
│   ├── home_screen.dart          # 主应用导航相关
│   ├── main.dart                 # 主应用入口
│   └── routes.dart               # 路由管理
├── test                          # 工程测试文件
├── web                           # Web工程文件
├── .gitignore                    # Git提交仓库忽略文件配置
├── .metadata                     # 当前workspace配置记录
├── analysis_options.yaml         # Dart语言代码规范(linter)
├── pubspec.lock                  # 依赖生成的文件
└── pubspec.yaml                  # 核心配置文件(项目配置、依赖等)
```

