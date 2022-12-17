/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPTextElement : public QCPLayoutElement /NoDefaultCtors/
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  explicit QCPTextElement(QCustomPlot *parentPlot /TransferThis/);
  QCPTextElement(QCustomPlot *parentPlot /TransferThis/, const QString &text);
  QCPTextElement(QCustomPlot *parentPlot /TransferThis/, const QString &text, double pointSize);
  QCPTextElement(QCustomPlot *parentPlot /TransferThis/, const QString &text, const QString &fontFamily, double pointSize);
  QCPTextElement(QCustomPlot *parentPlot /TransferThis/, const QString &text, const QFont &font);

  // getters:
  QString text() const;
  int textFlags() const;
  QFont font() const;
  QColor textColor() const;
  QFont selectedFont() const;
  QColor selectedTextColor() const;
  bool selectable() const;
  bool selected() const;

  // setters:
  void setText(const QString &text);
  void setTextFlags(int flags);
  void setFont(const QFont &font);
  void setTextColor(const QColor &color);
  void setSelectedFont(const QFont &font);
  void setSelectedTextColor(const QColor &color);
  Q_SLOT void setSelectable(bool selectable);
  Q_SLOT void setSelected(bool selected);

  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  virtual void mousePressEvent(QMouseEvent *event, const QVariant &details);
  virtual void mouseReleaseEvent(QMouseEvent *event, const QPointF &startPos);
  virtual void mouseDoubleClickEvent(QMouseEvent *event, const QVariant &details);

signals:
  void selectionChanged(bool selected);
  void selectableChanged(bool selectable);
  void clicked(QMouseEvent *event);
  void doubleClicked(QMouseEvent *event);

protected:
  // reimplemented virtual methods:
  virtual void applyDefaultAntialiasingHint(QCPPainter *painter) const;
  virtual void draw(QCPPainter *painter);
  virtual QSize minimumOuterSizeHint() const;
  virtual QSize maximumOuterSizeHint() const;
  // events:
  virtual void selectEvent(QMouseEvent *event, bool additive, const QVariant &details, bool *selectionStateChanged);
  virtual void deselectEvent(bool *selectionStateChanged);

  // non-virtual methods:
  QFont mainFont() const;
  QColor mainTextColor() const;
};
