document =
"""
PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiID8+CgogICAgICAgIDx0ZmQ6VGltYnJlRmlzY2FsRGlnaXRhbCB4bWxuczp0ZmQ9Imh0dHA6Ly93d3cuc2F0LmdvYi5teC9UaW1icmVGaXNjYWxEaWdpdGFsIiB4c2k6c2NoZW1hTG9jYXRpb249Imh0dHA6Ly93d3cuc2F0LmdvYi5teC9UaW1icmVGaXNjYWxEaWdpdGFsIGh0dHA6Ly93d3cuc2F0LmdvYi5teC9zaXRpb19pbnRlcm5ldC9jZmQvVGltYnJlRmlzY2FsRGlnaXRhbC9UaW1icmVGaXNjYWxEaWdpdGFsdjExLnhzZCIgVmVyc2lvbj0iMS4xIiBVVUlEPSIxMDliNTQ3NS00ODg5LTQ1YjktOGQyNS1kMWJmN2UyNDQ2ZjYiIFJmY1Byb3ZDZXJ0aWY9IlNQUjE5MDYxM0k1MiIgRmVjaGFUaW1icmFkbz0iMjAyMi0xMC0xM1QxMToxODo0OCIgU2VsbG9DRkQ9IlRmYnlpMSs2YWdrcGJBaE5pTERHVHhoZEZwSndxQ3dYdjFWTXBsRWxkNHBxZHlMek9oM3A5WFNLMm91NS9ERkE1eVBzQ3hxUHBZSGN6MURSQ1l5Uyt4Y3JESmNtdlZyVnFIQnF1NTM1elhuVlpHR0djN0RqbXNVRi9Icm1palk3YWpIQzM4RHF6Vnk5RmVSTjIwM21XNEpyTmRneTBEQXRXV0tCSUNkeDZEU0VUNVpieDFJS0I4ZTQ1NTlrRmFVSEUwQlV6UHd3YVYyWmRnNjI2Snp5RFZxTlhTUkNHM0grdlRlUkdBTnVMVHBaNTJJbEQrUDNJeUQrK1E3VGZyV3A1U2NRczUyYy9RNzJoTzRxTEd4djlReXFEZSszVzBPR0F0L3Z0cGVWTktUY21LRWhHeEo2MGEyemQ1L29RTWFsQ1VyMnhLVHdLY3JhNHVNKytFV0Q0UT09IiBOb0NlcnRpZmljYWRvU0FUPSIzMDAwMTAwMDAwMDQwMDAwMjQ5NSIgU2VsbG9TQVQ9IkQvSnIrYzBTbFd6SGxxWnhpL1htU0VZQXpDQlVKWkZHS0t5ZFBSMkpRWUdPM3VHVGFFaFpMNmUxekNMa2JWQ0wvcXZwd3pSVUpTTjJBVEpEd01DN0w4UUs2TDlUdTBadXIzbDMxL3dudW5HcGdzSmJETEJRMitlZHRxa2FJcWxoRlpTbUR6Zk81LzFRcVpFUFUwUndCNE9oOGNVOTFtTkxBbUdVa05JeEdlcS84MHl2ZGJqUU8rRDBLcmwwOURScFMzVWwwZFk0WUJlQ1RFWHIrMnp2aUNhbXc5aWFjRk4wRkxmTk04SFg1NG0zTU16d0lvRFQ3U2RuZmZHSVhYVkZ6ZWJ6K29IQkc4L1NOR1gyak9VMWJhT21rMDZ3TDdOdWJjdno5aE8xTkt0ZnRrMThGQzN6T0ZkbGNONHZrblliSmt0RWRPZWIxZCt5OHJSWTREOVpRUT09Ii8+CiAgICA8L2NmZGk6Q29tcGxlbWVudG8+ICAgIAo8Y2ZkaTpFbWlzb3IgUmZjPSJGVU5LNjcxMjI4UEg2IiBOb21icmU9IktBUkxBIEZVRU5URSBOT0xBU0NPIiBSZWdpbWVuRmlzY2FsPSI2MTIiLz4KICAgIDxjZmRpOlJlY2VwdG9yIFJmYz0iQUFRTTYxMDkxN1FKQSIgTm9tYnJlPSJDQVJMT1MgRkVSTkFORE8gVmlydHVhbCBTQU5DSEVaIiBEb21pY2lsaW9GaXNjYWxSZWNlcHRvcj0iNjQxMDgiIFJlZ2ltZW5GaXNjYWxSZWNlcHRvcj0iNjEyIiBVc29DRkRJPSJHMDEiLz4KICAgIDxjZmRpOkNvbmNlcHRvcz4KICAgICAgICA8Y2ZkaTpDb25jZXB0byBDbGF2ZVByb2RTZXJ2PSIwMTAxMDEwMSIgTm9JZGVudGlmaWNhY2lvbj0iQTFCMkMzRDQiIENhbnRpZGFkPSIxLjAwMDAwMCIgQ2xhdmVVbmlkYWQ9Ikg4NyIgVW5pZGFkPSJQaWV6YSIgRGVzY3JpcGNpb249IkNvbmNlcHRvIGRlIHBydWViYSIgVmFsb3JVbml0YXJpbz0iNTAwMC4wMDAwMDAiIEltcG9ydGU9IjUwMDAuMDAwMDAwIiBPYmpldG9JbXA9IjAyIj4KICAgICAgICAgICAgPGNmZGk6SW1wdWVzdG9zPgogICAgICAgICAgICAgICAgPGNmZGk6VHJhc2xhZG9zPgogICAgICAgICAgICAgICAgICAgIDxjZmRpOlRyYXNsYWRvIEJhc2U9IjUwMDAuMDAiIEltcHVlc3RvPSIwMDIiIFRpcG9GYWN0b3I9IlRhc2EiIFRhc2FPQ3VvdGE9IjAuMTYwMDAwIiBJbXBvcnRlPSI4MDAuMDAiLz4KICAgICAgICAgICAgICAgIDwvY2ZkaTpUcmFzbGFkb3M+CiAgICAgICAgICAgIDwvY2ZkaTpJbXB1ZXN0b3M+CiAgICAgICAgPC9jZmRpOkNvbmNlcHRvPgogICAgICAgIDxjZmRpOkNvbmNlcHRvIENsYXZlUHJvZFNlcnY9IjAxMDEwMTAxIiBOb0lkZW50aWZpY2FjaW9uPSJBMUIyQzNENCIgQ2FudGlkYWQ9IjEuMDAwMDAwIiBDbGF2ZVVuaWRhZD0iSDg3IiBVbmlkYWQ9IlBpZXphIiBEZXNjcmlwY2lvbj0iQ29uY2VwdG8gZGUgcHJ1ZWJhIiBWYWxvclVuaXRhcmlvPSI1MDAwLjAwMDAwMCIgSW1wb3J0ZT0iNTAwMC4wMDAwMDAiIE9iamV0b0ltcD0iMDIiPgogICAgICAgICAgICA8Y2ZkaTpJbXB1ZXN0b3M+CiAgICAgICAgICAgICAgICA8Y2ZkaTpUcmFzbGFkb3M+CiAgICAgICAgICAgICAgICAgICAgPGNmZGk6VHJhc2xhZG8gQmFzZT0iNTAwMC4wMCIgSW1wdWVzdG89IjAwMiIgVGlwb0ZhY3Rvcj0iRXhlbnRvIi8+CiAgICAgICAgICAgICAgICA8L2NmZGk6VHJhc2xhZG9zPgogICAgICAgICAgICA8L2NmZGk6SW1wdWVzdG9zPgogICAgICAgIDwvY2ZkaTpDb25jZXB0bz4KICAgIDwvY2ZkaTpDb25jZXB0b3M+CiAgICA8Y2ZkaTpJbXB1ZXN0b3MgVG90YWxJbXB1ZXN0b3NUcmFzbGFkYWRvcz0iODAwLjAwIj4KICAgICAgICA8Y2ZkaTpUcmFzbGFkb3M+CiAgICAgICAgICAgIDxjZmRpOlRyYXNsYWRvIEJhc2U9IjUwMDAuMDAiIEltcHVlc3RvPSIwMDIiIFRpcG9GYWN0b3I9IlRhc2EiIFRhc2FPQ3VvdGE9IjAuMTYwMDAwIiBJbXBvcnRlPSI4MDAuMDAiLz4KICAgICAgICA8L2NmZGk6VHJhc2xhZG9zPgogICAgPC9jZmRpOkltcHVlc3Rvcz4KPGNmZGk6Q29tcHJvYmFudGUgeG1sbnM6Y2F0Q0ZEST0iaHR0cDovL3d3dy5zYXQuZ29iLm14L3NpdGlvX2ludGVybmV0L2NmZC9jYXRhbG9nb3MiIHhtbG5zOnRkQ0ZEST0iaHR0cDovL3d3dy5zYXQuZ29iLm14L3NpdGlvX2ludGVybmV0L2NmZC90aXBvRGF0b3MvdGRDRkRJIiB4bWxuczpjZmRpPSJodHRwOi8vd3d3LnNhdC5nb2IubXgvY2ZkLzQiIHhtbG5zOnhzaT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS9YTUxTY2hlbWEtaW5zdGFuY2UiIHhzaTpzY2hlbWFMb2NhdGlvbj0iaHR0cDovL3d3dy5zYXQuZ29iLm14L2NmZC80IGh0dHA6Ly93d3cuc2F0LmdvYi5teC9zaXRpb19pbnRlcm5ldC9jZmQvNC9jZmR2NDAueHNkIiBWZXJzaW9uPSI0LjAiIFNlcmllPSJDRkRJIiBGb2xpbz0iMDAxIiBGZWNoYT0iMjAyMi0xMC0xM1QxMToxODo0NyIgU2VsbG89IlRmYnlpMSs2YWdrcGJBaE5pTERHVHhoZEZwSndxQ3dYdjFWTXBsRWxkNHBxZHlMek9oM3A5WFNLMm91NS9ERkE1eVBzQ3hxUHBZSGN6MURSQ1l5Uyt4Y3JESmNtdlZyVnFIQnF1NTM1elhuVlpHR0djN0RqbXNVRi9Icm1palk3YWpIQzM4RHF6Vnk5RmVSTjIwM21XNEpyTmRneTBEQXRXV0tCSUNkeDZEU0VUNVpieDFJS0I4ZTQ1NTlrRmFVSEUwQlV6UHd3YVYyWmRnNjI2Snp5RFZxTlhTUkNHM0grdlRlUkdBTnVMVHBaNTJJbEQrUDNJeUQrK1E3VGZyV3A1U2NRczUyYy9RNzJoTzRxTEd4djlReXFEZSszVzBPR0F0L3Z0cGVWTktUY21LRWhHeEo2MGEyemQ1L29RTWFsQ1VyMnhLVHdLY3JhNHVNKytFV0Q0UT09IiBGb3JtYVBhZ289IjAxIiBOb0NlcnRpZmljYWRvPSIzMDAwMTAwMDAwMDQwMDAwMjMyMSIgQ2VydGlmaWNhZG89Ik1JSUZpakNDQTNLZ0F3SUJBZ0lVTXpBd01ERXdNREF3TURBME1EQXdNREl6TWpFd0RRWUpLb1pJaHZjTkFRRUxCUUF3Z2dFck1ROHdEUVlEVlFRRERBWkJReUJWUVZReExqQXNCZ05WQkFvTUpWTkZVbFpKUTBsUElFUkZJRUZFVFVsT1NWTlVVa0ZEU1U5T0lGUlNTVUpWVkVGU1NVRXhHakFZQmdOVkJBc01FVk5CVkMxSlJWTWdRWFYwYUc5eWFYUjVNU2d3SmdZSktvWklodmNOQVFrQkZobHZjMk5oY2k1dFlYSjBhVzVsZWtCellYUXVaMjlpTG0xNE1SMHdHd1lEVlFRSkRCUXpjbUVnWTJWeWNtRmtZU0JrWlNCallXUnBlakVPTUF3R0ExVUVFUXdGTURZek56QXhDekFKQmdOVkJBWVRBazFZTVJrd0Z3WURWUVFJREJCRFNWVkVRVVFnUkVVZ1RVVllTVU5QTVJFd0R3WURWUVFIREFoRFQxbFBRVU5CVGpFUk1BOEdBMVVFTFJNSU1pNDFMalF1TkRVeEpUQWpCZ2txaGtpRzl3MEJDUUlURm5KbGMzQnZibk5oWW14bE9pQkJRMFJOUVMxVFFWUXdIaGNOTVRrd05USTVNVGN4TnpRd1doY05Nak13TlRJNU1UY3hOelF3V2pDQnNURWRNQnNHQTFVRUF4TVVTMEZTVEVFZ1JsVkZUbFJGSUU1UFRFRlRRMDh4SFRBYkJnTlZCQ2tURkV0QlVreEJJRVpWUlU1VVJTQk9UMHhCVTBOUE1SMHdHd1lEVlFRS0V4UkxRVkpNUVNCR1ZVVk9WRVVnVGs5TVFWTkRUekVXTUJRR0ExVUVMUk1OUmxWT1N6WTNNVEl5T0ZCSU5qRWJNQmtHQTFVRUJSTVNSbFZPU3pZM01USXlPRTFEVEU1TVVqQTFNUjB3R3dZRFZRUUxFeFJMUVZKTVFTQkdWVVZPVkVVZ1RrOU1RVk5EVHpDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTGNpZ1IwLzI3bnNCVmdyYkIvbmVCc1k3UjNjUnZSM0thOXc0b3ZSdHBOMnBlNjJBNWRmZXc3ZU5hYVhRRVNGL2JjYmFxL2JJOVZ1STVOSnF4eDBRVklSUm4rcEFKYjUzUHNNVlZBajgxSm9QVWlzbGgwQWx4dU1IaEk4VHhwR213clZVK1BlamZ1UTQ5d3FmUXNPbnFZQXVIaTBQdnZ6RS9OMkphMzIreUVPTXpFNDBCME9xb0JPMnQ5M0kraGUrL1RIWGhpakVLZWVTTzRzK2tnTkJVS3ZaTnF1LzAwUnJxdTVEamZGTEZIQ3dxQlFyYXltMXhsU0J0N0MzbThuR3NQYm4vUjBCTXlwZlNaUFN1UUpOeERYMFczK3pobEtybkZNTVFXRUhnTUo3NWtRUEloSExOKy9NS1VlM2o3NVZpREw2ZWp1cE4vRE8vQXRZSGNNdFBzQ0F3RUFBYU1kTUJzd0RBWURWUjBUQVFIL0JBSXdBREFMQmdOVkhROEVCQU1DQnNBd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dJQkFDZHBmK1lxeEtoVnlIL25UeG5aSFRiZzRCek1vQ3JDNU5YS1U0WFV2WjM3L0UxZnpxTEljTGFOWlVJd2R3aEt3NXFRck5JYm4wQUV0V0EvUElIVWVBZmZvSk9NV2tsTmxHTU9lWGxYNlBtQUY2OTJ5d0lTTHhoeTdOdDlhTFlJcjR5VDZQOGE4elI5ZW0wQjZndVczQnVkU05LSXVpK0ZwVFlObUNwdHRTUGZKMDdsdllZMVZZdkd3QXF3bkF6V1VXSHFvaDFTNlkrcUt4dlVBdzZDajNuM0ExaVFpV3FyQ0ZCZWFvZTJpdzA1MGpUUlQvVEh4NHFJR0FxUUpTWWlPK3o1eGppVXhUbnhaQmo3WkdBampOSVRnK0FFbnFFbnlZVW5qaFJMcTM4QmxKVHZhUHJBbVh1aXNKVjhZR3Z3dnV5ckJHL2VTWnFuTGYxTWtEMlo1YVgyTDJibG12VXhwVFNVdzlrejJzY1hVVlVCaUJpVzNBWHp0cnRNNUR5ZzNPL3ZHZEZPUGgxZjlDTnV6RENnYlVBZTJpZkl5UFl0SktBbWljTWF0YzI3OStaMTRNcHFwc1drZ3ZISFBFMkQ4dGxzbm5ySXM1ZVQrZ2hLaE90UUtDWHJ3djdraFRVM3N6Sk9qVEZ2QU55NlY2aWlFc3dBQm40ZmJLVndLM1hid3d0V2E5b01GajRoSFZpNkxBejl6ZThSMzZNRnErTzZFUklsVnFEL3NWY3lwVTJtRUVqcVJ5cFA4bHU2cU82b1VvMWx0OTFUcXFCTGpGejFkSU45QjRvK3ZwaWtVbENKbGRPU3ZoSE50d21nL2xnZXB4UjlQMlJZSmhINXh6KzZ0bE0xL0ZzOVNBWVk1Mmc2bnFNbXhjZGRmTU5RS3AxNXUwRFc1dWUrNEY1bSIgQ29uZGljaW9uZXNEZVBhZ289IjMwIGTDrWFzIiBTdWJUb3RhbD0iMTAwMDAuMDAiIFRvdGFsPSIxMDgwMC4wMCIgTW9uZWRhPSJNWE4iIFRpcG9EZUNvbXByb2JhbnRlPSJJIiBFeHBvcnRhY2lvbj0iMDEiIE1ldG9kb1BhZ289IlBVRSIgTHVnYXJFeHBlZGljaW9uPSI2NDAwMCI+CjxjZmRpOkNvbXBsZW1lbnRvPgo8L2NmZGk6Q29tcHJvYmFudGU+
"""
|> Base.decode64!
:xmerl_scan.string(document)
xml =
"""
<message>
  <warning id="1">
    Hola, mundo
    <elem1 att1="a" />
  </warning>
</message>
"""
{:xmlElement, :message, :message, [], {:xmlNamespace, [], []}, [], 1, [],
 [
   {:xmlText, [message: 1], 1, [], '\n  ', :text},
   {:xmlElement, :warning, :warning, [], {:xmlNamespace, [], []}, [message: 1],
    2,
    [
      {:xmlAttribute, :id, :id, [], {:xmlNamespace, [], []},
       [warning: 2, message: 1], 1, [], '1', false}
    ],
    [
      {:xmlText, [warning: 2, message: 1], 1, [], '\n    Hola, mundo\n    ',
       :text},
      {:xmlElement, :elem1, :elem1, [], {:xmlNamespace, [], []},
       [warning: 2, message: 1], 2,
       [
         {:xmlAttribute, :att1, :att1, [], {:xmlNamespace, [], []},
          [elem1: 2, warning: 2, message: 1], 1, [], 'a', false}
       ], [], [], '/home/dozenth/Codes/DVZ/documentRules/document_rules',
       :undeclared},
      {:xmlText, [warning: 2, message: 1], 3, [], '\n  ', :text}
    ], [], '/home/dozenth/Codes/DVZ/documentRules/document_rules', :undeclared},
   {:xmlText, [message: 1], 3, [], '\n', :text}
 ], [], '/home/dozenth/Codes/DVZ/documentRules/document_rules', :undeclared}
