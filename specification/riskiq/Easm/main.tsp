import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "./routes.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using TypeSpec.Versioning;

@useAuth(
  OAuth2Auth<[
    {
      @doc("implicit flow")
      type: OAuth2FlowType.implicit,

      @doc("the authorization URL")
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",

      @doc("list of scopes for the credential")
      scopes: ["https://easm.defender.microsoft.com/.default"],
    }
  ]>
)
@versioned(Easm.Versions)
@service({
  title: "Defender EASM",
})
@server(
  "{endpoint}/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/workspaces/{workspaceName}",
  "",
  {
    @doc("The endpoint hosting the requested resource. For example, https://{region}.easm.defender.microsoft.com")
    endpoint: string,

    @doc("The ID of the target subscription.")
    subscriptionId: string,

    @doc("The name of the Resource Group.")
    resourceGroupName: string,

    @doc("The name of the Workspace.")
    workspaceName: string,
  }
)
@doc("Defender EASM discovers and maps your digital attack surface to provide an \"outside-in\" perspective using probes to discover assets. The assets are provided with detailed metadata associated, including vulnerabilities, configurations and web components, allowing customers to view and prioritize external risk. The EASM REST API enables you to develop clients that integrate with your application.")
namespace Easm;
@doc("The EASM Defender service version.")
enum Versions {
  @doc("Version 2023-03-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_03_01_preview: "2023-03-01-preview",
}
