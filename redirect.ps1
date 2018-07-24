 $a = get-childitem .\rd

 $b = $a.pschildname -split ('\.') -ne 'yml'

$rdname = $b |select-string -pattern '[a-z]\-[a-z]'

# first-last

#$urlname = $rdname -Replace("-",".")

$redirectfile = "redirect.json"

$header = @"
{
    "redirections": [
"@

$footer = @"
  ]
}

"@

New-Item -path . -name $redirectfile -itemtype "file" -force

add-content -path $redirectfile -value $header

foreach($i in $rdname) {


    $urlname = $i -replace("-",".")

    $content = @"
    {
        "source_path": "rd/$urlname.md",
        "redirect_url": "/$i",
        "redirect_document_id": false
     }
"@


add-content -path $redirectfile -value $content
add-content -path $redirectfile -value ","



}


<#

ForEach($content in $name) {

    $content = @"

        {
            "source_path": "rd/$urlname.md",
            "redirect_url": "/rd/$name",
            "redirect_document_id": false
         }


"@

write-host "Write"
add-content -path $redirectfile -value $content
add-content -path $redirectfile -value ","


}  #>






add-content -path $redirectfile -value $footer




