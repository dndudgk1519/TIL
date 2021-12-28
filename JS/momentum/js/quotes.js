const quotes = [
    {
        quote:"Reading is to the mind what exercise is to the body",
        author:"Joseph Addison",
    },
    {
        quote:"We are what we repeatedly do. Excellence then is not an act but a habit",
        author:"Aristotle",
    },
    {
        quote:"The reason I exercise is for the quality of life I enjoy",
        author:"Kenneth H.Cooper",
    },
    {
        quote:"It's easier to wake up early in the morning & work out, than it is to look in the mirror each day & not like what you see",
        author:"Someone",
    },
    {
        quote:"Exercise to stimulate, not to annihilate. The world wasn't formed in a day, and neither were we. Set small goals and build upon them.",
        author:"Lee Haney",
    },
    {
        quote:"If we could give every individual the right amount of nourishment and exercise, not too little and not too much, we would have found the safest way to health",
        author:"Hippocrates",
    },
    {
        quote:"It is a shame for a man to grow old without seeing the beauty and strength of which his body is capable",
        author:"Socrates",
    },
    {
        quote:"Exercise is a celebration of what your body can do. Now a punishment for what you ate",
        author:"Neighborhood",
    },
    {
        quote:"Movement is a medicine for creating change in a person's physical, emotional, and mental states",
        author:"Carol Welch",
    },




];

const quote = document.querySelector("#quote span:first-child");
const author = document.querySelector("#quote span:last-child");

const todaysQuote = quotes[Math.floor(Math.random() * quotes.length)];

quote.innerText = todaysQuote.quote;
author.innerText= todaysQuote.author;