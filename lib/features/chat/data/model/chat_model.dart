

class ChatModel {
  List<Candidates>? candidates;
  UsageMetadata? usageMetadata;
  String? modelVersion;
  String? responseId;
    bool isUser=false; 


  ChatModel({this.candidates, this.usageMetadata, this.modelVersion, this.responseId,this.isUser=false});

  ChatModel.fromJson(Map<String, dynamic> json) {
    candidates = json["candidates"] == null
        ? null
        : (json["candidates"] as List).map((e) => Candidates.fromJson(e)).toList();
    usageMetadata = json["usageMetadata"] == null ? null : UsageMetadata.fromJson(json["usageMetadata"]);
    modelVersion = json["modelVersion"];
    responseId = json["responseId"];
    isUser = json["isUser"] ?? false; 

    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (candidates != null) {
      _data["candidates"] = candidates?.map((e) => e.toJson()).toList();
    }
    if (usageMetadata != null) {
      _data["usageMetadata"] = usageMetadata?.toJson();
    }
    _data["modelVersion"] = modelVersion;
    _data["responseId"] = responseId;
    return _data;
  }

  String get firstMessage {
    if (candidates != null && candidates!.isNotEmpty) {
      final content = candidates!.first.content;
      if (content != null && content.parts != null && content.parts!.isNotEmpty) {
        return content.parts!.map((e) => e.text ?? "").join(" ");
      }
    }
    return "";
  }
}
class UsageMetadata {
    int? promptTokenCount;
    int? candidatesTokenCount;
    int? totalTokenCount;
    List<PromptTokensDetails>? promptTokensDetails;
    int? thoughtsTokenCount;

    UsageMetadata({this.promptTokenCount, this.candidatesTokenCount, this.totalTokenCount, this.promptTokensDetails, this.thoughtsTokenCount});

    UsageMetadata.fromJson(Map<String, dynamic> json) {
        promptTokenCount = json["promptTokenCount"];
        candidatesTokenCount = json["candidatesTokenCount"];
        totalTokenCount = json["totalTokenCount"];
        promptTokensDetails = json["promptTokensDetails"] == null ? null : (json["promptTokensDetails"] as List).map((e) => PromptTokensDetails.fromJson(e)).toList();
        thoughtsTokenCount = json["thoughtsTokenCount"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["promptTokenCount"] = promptTokenCount;
        _data["candidatesTokenCount"] = candidatesTokenCount;
        _data["totalTokenCount"] = totalTokenCount;
        if(promptTokensDetails != null) {
            _data["promptTokensDetails"] = promptTokensDetails?.map((e) => e.toJson()).toList();
        }
        _data["thoughtsTokenCount"] = thoughtsTokenCount;
        return _data;
    }
}

class PromptTokensDetails {
    String? modality;
    int? tokenCount;

    PromptTokensDetails({this.modality, this.tokenCount});

    PromptTokensDetails.fromJson(Map<String, dynamic> json) {
        modality = json["modality"];
        tokenCount = json["tokenCount"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["modality"] = modality;
        _data["tokenCount"] = tokenCount;
        return _data;
    }
}

class Candidates {
    Content? content;
    String? finishReason;
    int? index;

    Candidates({this.content, this.finishReason, this.index});

    Candidates.fromJson(Map<String, dynamic> json) {
        content = json["content"] == null ? null : Content.fromJson(json["content"]);
        finishReason = json["finishReason"];
        index = json["index"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(content != null) {
            _data["content"] = content?.toJson();
        }
        _data["finishReason"] = finishReason;
        _data["index"] = index;
        return _data;
    }
}

class Content {
    List<Parts>? parts;
    String? role;

    Content({this.parts, this.role});

    Content.fromJson(Map<String, dynamic> json) {
        parts = json["parts"] == null ? null : (json["parts"] as List).map((e) => Parts.fromJson(e)).toList();
        role = json["role"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(parts != null) {
            _data["parts"] = parts?.map((e) => e.toJson()).toList();
        }
        _data["role"] = role;
        return _data;
    }
}

class Parts {
    String? text;

    Parts({this.text});

    Parts.fromJson(Map<String, dynamic> json) {
        text = json["text"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["text"] = text;
        return _data;
    }
    
}