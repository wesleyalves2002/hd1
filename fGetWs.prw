#Include "TOTVS.CH"


/*
@Protheus.doc {}
@author Wesley Alves
@type Function User function 
@param Nil 
@since 05/04/2026
@description Funcao para consumir WS, busca por dados do cep
*/

User function fBuscaCEp()

    Local oRest        := FWRest():New("https://viacep.com.br/ws")// atrubui o endereco ao objeto instanciado
    Local aArea        := GetArea()
    Local aHeader      := {}
    Local cCep         := "02124000"
    Local cLastError   := ""
    Local cErrorDatail := ""
    Local cResult      := ""
    Local cCepret      := ""
    // Obejto que ira receber o retorno da request
    Local oJsonResult  := Nil
    

    // Adicionando os Heders que serao enviados via WS
    aAdd(aHeader,'User-Agent: Mozilla/4.0(compatible; Protheus '+GetBuild()+')')
    aAdd(aHeader,'Content-Type: application/json; charset=uft-8')

    // Define URL conforme o CEP e adiciona o Metodo GET
    oRest:setpath("/"+cCep+"/json") // setpath concatena a url contida no oRest com o cep 

    If oRest:get(aHeader) // Executa metodo Get 

        oJsonResult :=JsonObject():New()
        oJsonResult:FromJson(oRest:cResult)

        cCepret := oJsonResult:GetJsonObject("cep")
        cCepret := StrTran(cCepret,"-","")
        // Exibe resultado
        cResult := oRest:cResult 

        MsgInfo(cResult)

    Else
        // Se nao achar pega o erro e exibe em um alerta        
        cLastError   := oRest:GetLastError()
        cErrorDatail := oRest:GetResult()
        Alert(cErrorDatail)
    Endif 
    //Restaurando a Area
    FWRestArea(aArea)
Return 
