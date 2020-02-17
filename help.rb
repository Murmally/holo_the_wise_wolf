class Help
  def self.handle_school_help(event)
    event << "`h!get_definition [SUBJECT] [term]` => get definition, eg. `h!get_definition ISA Tok`"
    event << "`h!add_definition [SUBJECT] [term] [definition...]` => add definition to a subject (Helper/Mod only)"
    event << "`h!add_subject [SUBJECT]` => add a subject to list of subjects, eg. `h!add_subject IZP` (Helper/Mod only)"
    event << "`h!subject_definitions [SUBJECT]` => get all definitions from given subject, eg. `h!subject_definitions IZP`"
    event << "`h!subjects` => get list of subjects\n"

    event << "h!FIT_zaznamy_link"
    event << "h!FIT_video_link\n"

    event << "h!help => list of several useless (although mildly entertaining) commands"
  end


  def self.handle_help_random(event)
    event << "h!pasta => get random copypasta"
    event << "h!pastas => list of all copypastas"
    event << "h!set_quote => set this bot's quote"
    event << "h!quote => get this bot's quote"
    event << "h!why_ruby => the decision-making behind choosing Ruby\n"
    event << "h!karma"
    event << "h!cbt"
    event << "h!exams"
    event << "h!linux"
    event << "h!racism"
    event << "h!flip"
    event << "h!JonLajoie"
    event << "h!somebody"
    event << "h!gender"
  end

  def self.handle_help(event)
    event << "h!help_random => Collection of very random features"
    event << "h!help_school => VUT FIT related"
  end

  def self.handle_big_boi_help(event, owner)
    if event.author.id != owner 
      return nil
    end
    event << "h!windmill"
    event << "h!whitelist"
    event << "h!JonLajoie"
    event << "h!bajkalarka"
    event << "h!somebody"
    event << "h!set_log"
    event << "h!kybl"
    event << "h!plna_taska"
    event << "h!gender"
  end
end