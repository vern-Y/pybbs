<#include "../common/layout.ftl">
<@html page_title="话题编辑">
<div class="row">
  <div class="col-md-9">
    <div class="panel panel-default">
      <div class="panel-heading">
        <a href="/">主页</a> / 话题编辑
      </div>
      <div class="panel-body">
        <form method="post" action="/topic/${topic.id}/edit" id="editForm">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

          <input type="hidden" name="nodeId" id="nodeId" value="${topic.node.id!}"/>
          <div class="form-group">
            <label for="title">标题</label>
            <div class="input-group">
              <span class="input-group-btn">
                <a id="choiceNode" class="btn btn-default" onclick="javascript:;" data-toggle="modal" data-target="#choiceModal">选择节点</a>
              </span>
              <input type="text" class="form-control" id="title" name="title" value="${topic.title!}" placeholder="标题">
            </div>
          </div>

        <#--editor component-->
          <#include "../components/editor.ftl"/>
          <@editor content=topic.content/>

          <button type="submit" class="btn btn-default">
            <span class="glyphicon glyphicon-send"></span> 发布
          </button>
          <span id="error_message"></span>
        </form>
      </div>
    </div>
  </div>
  <div class="col-md-3 hidden-sm hidden-xs">
    <#include "../components/create_topic_guide.ftl"/>
    <@create_topic_guide/>
  </div>
</div>
<div class="modal fade" id="choiceModal" tabindex="-1" role="dialog" aria-labelledby="choiceModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button id="closeChoiceModalBtn" type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">选择节点</h4>
      </div>
      <div class="modal-body">
        <@nodes_tag>
            <#list nodes as pnode>
          <div class="row" style="padding: 5px 0;">
            <div class="col-md-2">
              <div class="text-right">${pnode.name!}</div>
            </div>
            <div class="col-md-10 nodes">
                <#list pnode.list as node>
                  <a data-id="${node.id!}" href="javascript:;">${node.name!}</a>
                </#list>
            </div>
          </div>
            </#list>
        </@nodes_tag>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  $(function () {
    $(".nodes>a").click(function () {
      $("#nodeId").val($(this).attr('data-id'));
      $("#choiceNode").html($(this).text());
      $("#closeChoiceModalBtn").click();
    });

    $("#editForm").submit(function () {
      var error = $("#error_message");
      var title = $("#title").val();
      var nodeId = $("#nodeId").val();
      if(nodeId.length === 0) {
        error.html("请选择节点");
        return false;
      }
      if(title.length === 0) {
        error.html("请输入标题");
        return false;
      }
    });
  })
</script>
</@html>