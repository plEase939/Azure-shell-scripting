$subscriptions = Get-AzSubscription
$allRoutes = @()
foreach ($subscription in $subscriptions) {
  Set-AzContext -SubscriptionId $subscription.Id
    $routeTables = Get-AzRoutwTable
    foreach ($routeTable in $routeTables) {
      foreach ($route in $routeTable.Routes) {
        $routeInfo = [PSCustomObject]@{
          SubscriptionId = $subscription.Id
          SubscriptionName = $subscription.Name
          ResourceGroupName = $routeTable.ResourceGroupName
          RouteTableName = $routeTable.Name
          Name = $route.Name
          AddressPrefix = $route.AddressPrefix
          NextHopType = $route.NextHopType
          NextHopIpAddress = $route.NextHopIpAddress
        }
        $allRoutes += $routeInfo
      }
    }
}
$allRoutes | Export-Csv -Path "allRoutes.csv" -NoTypeInformation
  
