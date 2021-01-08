Dado('que acesso a página de cadastro') do
  visit "http://rocklov-web:3000/signup"
    end

  Quando('submeto o seguinte formulário de cadastro:') do |table|
  
    ## User = variável
    ## table = invoca o table da feature
    ## hashes = transforma a manipulação dos dados da tabela em hash
    ## first = pega o primeiro registro

    log table.hashes

    user = table.hashes.first

    log user
  

    # table is a Cucumber::MultilineArgument::DataTable
   
    MongoDB.new.remove_user(user[:email])

    find("#fullName").set user[:nome]
    find("#email").set user[:email]
    find("#password").set user[:senha]
    click_button "Cadastrar"

  end
  
  Então('sou redirecionado para o Dashboard') do
    expect(page).to have_css ".dashboard"
    end

  Então('vejo a mensagem de alerta: {string}') do |expected_alert|
    alert = find(".alert-dark")
    expect(alert.text).to eql expected_alert
  end