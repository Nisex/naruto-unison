module Model.Skill
  ( Skill(..), new, chakraClasses
  , Target(..)
  , Transform
  , defaultName
  ) where

import ClassyPrelude.Yesod

import           Model.Internal (Skill(..), Requirement(..), Target(..), Copying(..), Ninja)
import           Model.Channel (Channeling(..))
import qualified Model.Chakra as Chakra

-- | The type signature of 'changes'.
type Transform = (Ninja -> Skill -> Skill)

-- | Default values of a 'Skill'. Used as a 'Skill' constructor.
new :: Skill
new = Skill { name     = "Unnamed"
            , desc     = ""
            , require  = Usable
            , classes  = []
            , cost     = 0
            , cooldown = 0
            , varicd   = False
            , charges  = 0
            , channel  = Instant
            , start    = []
            , effects  = []
            , disrupt  = []
            , changes  = const id
            , copying  = NotCopied
            , pic      = False
            }

-- | Adds 'Bloodline', 'Genjutsu', 'Ninjutsu', 'Taijutsu', and 'Random'
-- to the 'classes' of a 'Skill' if they are included in its 'cost'.
chakraClasses :: Skill -> Skill
chakraClasses skill =
    skill { classes = Chakra.classes (cost skill) ++ classes skill }

-- | Replaces an empty string with a 'name'.
defaultName :: Text -> Skill -> Text
defaultName "" = name
defaultName name  = const name
