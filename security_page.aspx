<script runat="server" type="text/vb">

'
'
'  ATTENZIONE
'
'
'  QUESTA PAGINA E' STATA GENERATA AUTOMATICAMENTE DALL'AMMINISTRATORE DEL SERVER PER PREVENIRE ATTACCHI
'  DI TIPO SQL INJECTION VERSO IL TUO SITO
'
'
'  NON CANCELLARE NE MODIFICARE QUESTA PAGINA
'
'
'  IL TUO SITO WEB CONTIENE MATERIALE DI TIPO CMS (ES. JOOMLA, WORDPRESS, PHPBB, ETC.) CHE GENERALMENTE VENGONO
'  PRESI DI MIRA DA HACKERS AL FINE DI IMPOSSESSARSI DEL SITO PER COMMETTERE OPERAZIONI ILLECITE
'
'
'  QUESTA PAGINA CERCA DI RENDERE PIU' SICURO IL TUO CMS DAGLI ATTACCHI PIU' COMUNI (ES. SQL INJECTION)
'
'
'  SE DESIDERI MAGGIORI INFORMAZIONI SU QUESTA PAGINA CONTATTA IL SUPPORTO TECNICO RIPORTANDO IL CONTENUTO DI
'  QUESTA STESSA PAGINA
'
'
'
'
'

    Private Shared objSign As Object = New Object
    Private Shared BanList As Hashtable = New Hashtable
    Private Shared MinuteCounter As Hashtable = New Hashtable
    Private Shared LastDay As Integer = -1
    Private Shared LastHour As Integer = -1
    Private Shared LastMinute As Integer = -1

    Sub Page_Load(ByVal Sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        SyncLock objSign

            Dim PageName As String = Request.QueryString("page")
            If String.IsNullOrEmpty(PageName) OrElse PageName.Length > 3000 Then Return
            If PageName.Contains("?") Then PageName = PageName.Substring(0, PageName.IndexOf("?"))
            If String.IsNullOrEmpty(PageName) Then Return

            Dim HitPerMinute As Integer = 0
            If Not Integer.TryParse(Request.QueryString("hitperminute"), HitPerMinute) Then Return
            If HitPerMinute < 5 Then HitPerMinute = 5

            Dim PageNameKey As String = PageName & "-sp-listkey"

            If BanList.Contains(PageNameKey) Then
                If DateDiff(DateInterval.Minute, CDate(BanList.Item(PageNameKey)), Now) < 60 Then
                    System.Threading.Thread.Sleep(500)
                    Response.Write("KO")
                    Return
                Else
                    BanList.Remove(PageNameKey)
                End If
            End If

            If LastDay <> Now.Day Then
                MinuteCounter.Clear()
                LastDay = Now.Day
            End If
            If LastHour <> Now.Hour Then
                MinuteCounter.Clear()
                LastHour = Now.Hour
            End If
            If LastMinute <> Now.Minute Then
                MinuteCounter.Clear()
                LastMinute = Now.Minute
            End If

            If MinuteCounter.Contains(PageNameKey) Then
                MinuteCounter.Item(PageNameKey) = CInt(MinuteCounter.Item(PageNameKey)) + 1
                If CInt(MinuteCounter.Item(PageNameKey)) >= HitPerMinute Then
					If BanList.Count > 1000 Then BanList.Clear()
                    BanList.Add(PageNameKey, Now)
                    Response.Write("KO")
                    Return
                End If
            Else
                MinuteCounter.Add(PageNameKey, 1)
            End If

        End SyncLock

        Response.Write("OK")

    End Sub

</script>
