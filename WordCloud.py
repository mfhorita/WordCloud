import os
import codecs
import string
import wordcloud as wc
import matplotlib.pyplot as plt
from collections import Counter


def create_dictionary(clean_list, stop_words):

    word_count = dict()
    for word in clean_list:
        if word not in stop_words:
            if word in word_count:
                word_count[word] += 1
            else:
                word_count[word] = 1

    c_words = Counter(word_count)
    print(c_words.most_common(10))

    return dict(c_words)


# Abre arquivo texto
path = os.path.dirname(os.path.realpath(__file__))
text = codecs.open(path + '\\' + 'texto.txt', 'r', 'utf-8').read().lower()
# print(text)

# Palavras a serem destacadas
text += "horita " * 30
text += "python " * 15
text += "safra " * 7
text += "resultados " * 6

# Remove símbolos especiais
symbols = string.punctuation + string.digits + '•–'
for i in text:
    if i in symbols:
        text = text.replace(i, ' ')
text = text.lower().split()

# Lista de stopword
stopwords = set(wc.STOPWORDS)
stopwords.update(["e", "a", "o", "as", "os", "ao", "aos", "de", "da", "do", "das", "dos", "na", "nas", "no", "nos",
                  "meu", "em", "você", "pela", "para", "br", "org", "com", "tel", "linkedin", "ra", "gt", "um",
                  "mais", "g", "p", "x", "iii", "m", "s", "à", "limão", "sp", "são", "paulo", "bairro", "até",
                  "analista"])

# Counta palavras
words = create_dictionary(text, stopwords)
# print(words)

# Gerar uma wordcloud
# wordcloud = wc.WordCloud(background_color="black", repeat=False, width=6200, height=3200)   # Backgroud, black
# wordcloud = wc.WordCloud(background_color="white", repeat=False, width=6200, height=3200)   # Backgroud, white
# wordcloud = wc.WordCloud(background_color="black", repeat=False, width=3000, height=3000)   # Frontend, black
wordcloud = wc.WordCloud(background_color="white", repeat=False, width=3200, height=3200)   # Frontend, white
wordcloud.generate_from_frequencies(words)  # .generate(all_words)
# print(wordcloud.layout_)

# Mostrar a imagem final
fig, ax = plt.subplots(figsize=(10, 6))
ax.imshow(wordcloud, interpolation='bilinear')
ax.set_axis_off()
plt.show()

os.system("pause")
