*** Settings ***
Library     SeleniumLibrary
Library     XML
Library     OperatingSystem

*** Variables ***
${YOUTUBE}          https://www.youtube.com
${Video}            https://youtu.be/6HUThlEvHeQ?si=SyYvDvR--1ty1Bu4
${wait}             10s
${file}             comentarios.txt

#${Button_Pause}     //button[@title="Pausar (k)"]
${Comentarios}      //*[@id="comments"]
${comentario}       //*[@id="content-text"]   # XPath para os textos dos comentários

*** Keywords ***
Acessar Youtube
    Open Browser    ${Video}    chrome
    Maximize Browser Window

#Pausar Vídeo
#    Wait Until Element Is Visible    ${Button_Pause}
#    Click Element                    ${Button_Pause}
#    Sleep                            2s

Ir aos comentários
    Wait Until Element Is Visible    ${Comentarios}
    Scroll Element Into View         ${Comentarios}
    Sleep                            3s
    Execute Javascript               window.scrollBy(0, 1500)
    Wait Until Element Is Visible    ${comentario}
    Sleep                            2s

Guardar comentários

    ${contador} 	get element count   //*[@id="content-text"]

    FOR 	${var}	IN RANGE 	1 	 ${contador}
	    ${text}=            Get Text        //*[@class="style-scope ytd-item-section-renderer"]\[${var}]//*[@id="content-text"]
	    Append To File      ${file}         ${text}\n\n
    END

Fechar chrome
    Close Browser

*** Test Cases ***
Cenário1: Acessar Youtube e capturar comentário
    Acessar Youtube
   # Pausar Vídeo
    Ir aos comentários
    Guardar comentários
    Fechar chrome
