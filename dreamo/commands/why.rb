module Dreamo
  module Commands
    class Why < SlackRubyBot::Commands::Base

      match /^(why)/i

      def self.possible_responses
        [
          "Absurdity is one of the most human things about us: a manifestation of our most advanced and interesting characteristics.",
          "The point is... to live one's life in the full complexity of what one is, which is something much darker, more contradictory, more of a maelstrom of impulses and passions, of cruelty, ecstacy, and madness, than is apparent to the civilized being who glides on the surface and fits smoothly into the world.",
          "It is often remarked that nothing we do now will matter in a million years. But if that is true, then by the same token, nothing that will be the case in a million years matters now. In particular, it does not matter now that in million years nothing we do now will matter.",
          "Even if life as a whole is meaningless, perhaps that's nothing to worry about. Perhaps we can recognise it and just go on as before.",
          "Eventually, I believe, current attempts to understand the mind by analogy with man-made computers that can perform superbly some of the same external tasks as conscious beings will be recognized as a gigantic waste of time.",
          "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.",
          "Meaning lies as much\nin the mind of the reader\nas in the Haiku.",
          "Sometimes it seems as though each new step towards AI, rather than producing something which everyone agrees is real intelligence, merely reveals what real intelligence is not.",
          "I would like to understand things better, but I don’t want to understand them perfectly.",
          "It is the mark of an educated mind to be able to entertain a thought without accepting it.",
          "You can discover more about a person in an hour of play than in a year of conversation.",
          "'Yields falsehood when preceded by its quotation' yields falsehood when preceded by its quotation.",
          "To teach how to live without certainty, and yet without being paralyzed by hesitation, is perhaps the chief thing that philosophy, in our age, can still do for those who study it.",
          "We know very little, and yet it is astonishing that we know so much, and still more astonishing that so little knowledge can give us so much power.",
          "What you can imagine depends on what you know.",
          "In order to understand the world, one has to turn away from it on occasion.",
          "Where questions of style and exposition are concerned I try to follow a simple maxim: if you can't say it clearly you don't understand it yourself."
        ]
      end

      def self.random_response
        possible_responses.shuffle.first
      end

      def self.call client, data, match
        client.typing channel: data.channel
        msg = random_response
        client.say channel: data.channel, text: msg
      end

    end
  end
end
