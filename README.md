# nmlayer

是基于[http](https://pub.dartlang.org/packages/http/versions/0.11.3+16)库，用于轻松实现网络model层(network model layer: nmlayer)的工具

## 安装

```
dependencies:
  nmlayer: ^0.0.1
```

## 用法

* 引入包
```
import 'package:nmlayer.dart';
```

* 继承`BaseRequestModel` 实现对应的接口
```
class YourModel extends BaseRequestModel {
  //请求方式
  RequestMethod requestMethod() {
    return RequestMethod.GET;
  }

  //基础url
  String baseUrl() {
    return 'https://api.yoursite.com';
  }

  //自定义patch
  String path() {
    return ''/user/starred'';
  }

  //自定义headers
  Map<String, String> requestHeaders() {
    return {};
  }

  //自定义请求request body
  Map<String, dynamic> requestBody() {
    return {};
  }
}
```  

* 发送请求
```
import 'package:nmlayer.dart';

//实例化对象
YourModel requestModel = YourModel();
//简单发起请求
final response = await request(model:requestModel);
print(response);
```


## 进一步

这样在REST接口的处理的上就很有用, 例如实现一个github star功能

#### 1. 自定义star actions
```
enum StarActions {
  LIST,
  STAR,
  UNSTAR
}
```

#### 2. 实现BaseRequestModel
```
class StarRequestModel extends BaseRequestModel {

  StarActions action = StarActions.LIST;
  String owner = '';
  String repo = '';

  StarRequestModel(this.action, {
    this.owner,
    this.repo
  });

  RequestMethod requestMethod() {
    switch (this.action) {
      case StarActions.LIST:
        return RequestMethod.GET;
      case StarActions.STAR:
        return RequestMethod.PUT;
      case StarActions.UNSTAR:
        return RequestMethod.DELETE;
      default:
        return RequestMethod.GET;
    }
  }

  String baseUrl() {
    return 'https://api.github.com';
  }

  String path() {
    switch (this.action) {
      case StarActions.LIST:
        return '/user/starred';
      case StarActions.STAR:
        return '/user/starred/$owner/$repo';
      case StarActions.UNSTAR:
        return '/user/starred/$owner/$repo';
      default:
        return '';
    }
  }

  //headers
  Map<String, String> requestHeaders() {
    return {};
  }

  //request body
  Map<String, dynamic> requestBody() {
    return {'access_token': 'your access_token'};
  }
}
```

#### 3. 发起请求

```
//star指定的的respo
final action = StarActions.STAR;
final owner = 'owner of respo';
final respo = 'name of respo';
StarRequestModel requestModel = StarRequestModel(action, owner: owner, repo: respo);
final response = await request(model:requestModel);
return response;
```



