//
//  StandardGuides.swift
//  Coffee
//
//  Created by Michael Moore on 9/27/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class StandardGuides {
    
    let chemex = Guide(userGuide: false, title: BrewKeys.chemexKey, method: BrewKeys.chemexKey, methodInfo: "The CHEMEX was invented by a chemist in 1941.  The design was inspired by his lab equipment, and is displayed at museums throughtout the world.  It produces a clean, crisp, yet balanced cup of coffee.", coffee: 42.0, grind: GrindKeys.mediumCoarseKey, prep:
        """
        Things you'll need:
           8-cup CHEMEX brewer
           CHEMEX filter
           42g of ground coffee
           Scale
           Hot water just off the boil
           Stir stick
           Your favorite mug

        • Place filter in the brewer so that three folds are toward the spout
        • Thoroughly rinse the filter with hot water (this removes the paper taste from our coffee and preheats the CHEMEX)
        • Without removing the filter, discard the water
        • Add coffee, place the CHEMEX on the scale, and zero the scale
        • You're ready to start brewing!
        """,
        steps: [Step(title: "Pour", water: 150.0, time: 10.0, text: "Pour 150.0g of water saturating all the grounds over 10.0"), Step(title: "Stir", water: 0.0, time: 10.0, text: "Give the grounds a little stir ensuring there are no dry clumps"), Step(title: "Wait", water: 0.0, time: 25.0, text: "Wait for 25.0 seconds and let it bloom"), Step(title: "Pour", water: 300.0, time: 20.0, text: "Pour 300.0g in a spiraling motion over 20.0 seconds, and hitting all the dark spots"), Step(title: "Wait", water: 0.0, time: 40.0, text: "Wait for another 40 seconds"), Step(title: "Pour", water: 250.0, time: 17.0, text: "Pour 250.0g of water spiraling outward over 17.0 seconds"), Step(title: "Wait", water: 0.0, time: 118.0, text: "Wait until your coffee has reached the bubble on the front of the brewer"), Step(title: "Other", water: 0.0, time: 0.0, text: "Remove filter (even if there's still water filtering through)"), Step(title: "Other", water: 0.0, time: 0.0, text: "Give the CHEMEX a couple swirls, and enjoy!")])
    
    let aeroPress = Guide(userGuide: false, title: BrewKeys.aeroPressKey, method: BrewKeys.aeroPressKey, methodInfo: "The AeroPress was invented by Alan Adler, the same engineer of the Aerobie Frisbee, and allows for creative and various brewing methods.  Still, it provides a delicious, full-bodied cup in half the time.", coffee: 17.0, grind: GrindKeys.fineMediumKey, prep:
        """
        Things you'll need:
           AeroPress brewer
           AeroPress filter
           17g of ground coffee
           Scale
           Hot water just off the boil
           AeroPress paddle
           Your favorite mug

        • Place filter in the basket, attach to filter, and place on top of our mug
        • Thoroughly rinse the filter and with hot water (this removes the paper taste from our coffee, preheats the AeroPress, and our mug)
        • Discard the water from our mug
        • Add coffee into the brew chamber and place it back on top of our mug
        • Place the mug/AeroPress on the scale, and zero the scale
        • You're ready to start brewing!
        """,
        steps: [Step(title: "Pour", water: 220.0, time: 10.0, text: "Pour 220.0g (or about the #4 brewer mark) of water over 10 seconds, saturating all the grounds"), Step(title: "Stir", water: 0.0, time: 10.0, text: "Using the paddle, stir for 10.0 seconds"), Step(title: "Other", water: 0.0, time: 10.0, text: "Place the plunger in at an angle, and pull up slightly creating a pressure seal"), Step(title: "Wait", water: 0.0, time: 45.0, text: "Wait for 45.0 seconds"), Step(title: "Stir", water: 0.0, time: 5.0, text: "Remove plunger and stir for 5.0 seconds"), Step(title: "Other", water: 0.0, time: 35.0, text: "Place plunger back on, and steadily press down until you hear a hissing sound"), Step(title: "Other", water: 0.0, time: 0.0, text: "Remove basket from brewer and pop out the grounds/filter"), Step(title: "Other", water: 0.0, time: 0.0, text: "Clean the brewer, and enjoy your cup of coffee!")])
    
    let v60 = Guide(userGuide: false, title: BrewKeys.v60Key, method: BrewKeys.v60Key, methodInfo: "Despite originating in the 1980's, HARIO's floating filter design didn't become a favorite among baristas until 2004, when they introduced their signature sprial ribbed V60.  This allows the user to control the brewing extration based on the pour.  A staple in craft coffee shops everywhere, this brewer is versatile and produces a great cup of coffee.", coffee: 21.0, grind: GrindKeys.fineMediumKey, prep:
        """
        Things you'll need:
           Hario V60 brewer
           Hario V60 filter
           21g of ground coffee
           Scale
           Stir stick or spoon
           Hot water just off the boil
           Your favorite mug or carafe

        • Fold the filter at the seams to form a cone, place filter in brewer, and place on top of our mug/carafe
        • Thoroughly rinse the filter and with hot water (this removes the paper taste from our coffee, preheats the V60, and our mug)
        • Discard the water from our mug/carafe
        • Add coffee into the V60 ensuring a flat bed, and place it back on top of our mug
        • Place the mug/brewer on the scale, and zero the scale
        • You're ready to start brewing!
        """,
        steps: [Step(title: "Pour", water:  60.0, time: 5.0, text: "Pour 60.0g of water over 5.0 seconds saturating all the grounds"), Step(title: "Stir", water: 0.0, time: 3.0, text: "Stir for 3.0 seconds"), Step(title: "Wait", water: 0.0, time: 13.0, text: "Wait for 13.0 seconds and let bloom"), Step(title: "Pour", water: 75.0, time: 20.0, text: "Pour 75.0g of water in a slow, sprial motion for 20.0 seconds hitting the dark spots"), Step(title: "Wait", water: 0.0, time: 12.0, text: "Wait for 12.0 seconds"), Step(title: "Pour", water: 75.0, time: 20.0, text: "Pour 75.0g of water in a slow, sprial motion for 20.0 seconds hitting the dark spots"), Step(title: "Wait", water: 0.0, time: 12.0, text: "Wait for 12.0 seconds"), Step(title: "Pour", water: 75.0, time: 20.0, text: "Pour 75.0g of water in a slow, sprial motion for 20.0 seconds hitting the dark spots"), Step(title: "Wait", water: 0.0, time: 12.0, text: "Wait for 12.0 seconds"), Step(title: "Pour", water: 75.0, time: 20.0, text: "Pour 75.0g of water in a slow, sprial motion for 20.0 seconds hitting the dark spots"), Step(title: "Wait", water: 0.0, time: 40.0, text: "Wait for 40.0 seconds"), Step(title: "Other", water: 0.0, time: 0.0, text: "Set the V60 into the sink or another carafe/mug to let drain, and enjoy!")])
    
    let kalita = Guide(userGuide: false, title: BrewKeys.kalitaKey, method: BrewKeys.kalitaKey, methodInfo: "Similar to other pour overs, the Kalita Wave is all about mastering the slow, spiral pour.  However, unlike the HARIO V60, the Kalita Wave's flat bottom allows this brewing method to have a more even, consistent (thus more forgiving) extraction process.  The Kalita Wave produces a clean, balanced cup of coffee", coffee: 21.0, grind: GrindKeys.fineMediumKey, prep:
    """
    Things you'll need:
       Kalita Wave brewer
       Kalita Wave filter
       21g of ground coffee
       Scale
       Stir Stick or spoon
       Hot water just off the boil
       Your favorite mug or carafe

    • Place filter in brewer, and place on top of our mug/carafe
    • Thoroughly rinse the filter with hot water (this removes the paper taste from our coffee, preheats the V60, and our mug)
    • Discard the water from our mug/carafe
    • Add coffee into the filter ensuring a flat bed, and place it back on top of our mug
    • Place the mug/brewer on the scale, and zero the scale
    • You're ready to start brewing!
    """,
    steps: [Step(title: "Pour", water:  60.0, time: 10.0, text: "Pour 60.0g of water over 10.0 seconds saturating all the grounds"), Step(title: "Stir", water: 0.0, time: 3.0, text: "Stir for 3.0 seconds"), Step(title: "Wait", water: 0.0, time: 32.0, text: "Wait for 32.0 seconds and let bloom"), Step(title: "Pour", water: 140.0, time: 15.0, text: "Pour 140.0g of water in a slow, sprial motion for 15.0 seconds hitting the dark spots"), Step(title: "Wait", water: 0.0, time: 5.0, text: "Wait for 5.0 seconds"), Step(title: "Pour", water: 175.0, time: 55.0, text: "Pour 175.0g of water in 25-50g increments in a slow, sprial motion over 55.0 seconds hitting the dark spots"), Step(title: "Wait", water: 0.0, time: 50.0, text: "Wait for 50.0 seconds"), Step(title: "Other", water: 0.0, time: 0.0, text: "Set the Kalita into the sink or another carafe/mug to let drain. Pour your cup and enjoy!")])
    
    let frenchPress = Guide(userGuide: false, title: BrewKeys.frenchPressKey, method: BrewKeys.frenchPressKey, methodInfo: "A classic brewing method that is consistent and yields enough coffee for guests.  Although filtering the grounds to the bottom, the French Press keeps the oils and grounds in the coffee producing a full-bodied and gritty cup of coffee", coffee: 56.0, grind: GrindKeys.coarseKey, prep:
    """
    Things you'll need:
       8 cup French Press brewer
       56g of ground coffee
       Stir Stick or spoon
       Hot water just off the boil
       Your favorite mug or carafe

    • Thoroughly rinse and preheat the brewer with hot water
    • Discard the water from our mug/carafe
    • Add coffee to the French Press
    • You're ready to start brewing!
    """,
    steps: [Step(title: "Pour", water:  450.0, time: 10.0, text: "Fill the brewer half way with hot water over 10.0 seconds saturating all the grounds"), Step(title: "Wait", water: 0.0, time: 50.0, text: "Wait for 50.0 seconds"), Step(title: "Stir", water: 0.0, time: 5.0, text: "Stir for 5.0 seconds"), Step(title: "Pour", water:  450.0, time: 10.0, text: "Fill the brewer the rest of the way with hot water and put the top on (don't press it just yet)"), Step(title: "Wait", water: 0.0, time: 175.0, text: "Wait for 175.0 seconds"), Step(title: "Other", water: 0.0, time: 5.0, text: "With firm, yet consistent force, press the filter all the way down"), Step(title: "Other", water: 0.0, time: 0.0, text: "Serve and enjoy!"), Step(title: "Other", water: 0.0, time: 0.0, text: "Discard grounds by simply adding a little water and disposing of in the trash or compost")])
}
    
