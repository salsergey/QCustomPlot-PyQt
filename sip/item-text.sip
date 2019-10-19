/** PyQt5 binding for QCustomPlot v2.0.0
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPItemText : public QCPAbstractItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <QCustomPlot/src/items/item-text.h>
%End
public:
  explicit QCPItemText(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPItemText();
  
  // getters:
  QColor color() const;
  QColor selectedColor() const;
  QPen pen() const;
  QPen selectedPen() const;
  QBrush brush() const;
  QBrush selectedBrush() const;
  QFont font() const;
  QFont selectedFont() const;
  QString text() const;
  Qt::Alignment positionAlignment() const;
  Qt::Alignment textAlignment() const;
  double rotation() const;
  QMargins padding() const;
  
  // setters;
  void setColor(const QColor &color);
  void setSelectedColor(const QColor &color);
  void setPen(const QPen &pen);
  void setSelectedPen(const QPen &pen);
  void setBrush(const QBrush &brush);
  void setSelectedBrush(const QBrush &brush);
  void setFont(const QFont &font);
  void setSelectedFont(const QFont &font);
  void setText(const QString &text);
  void setPositionAlignment(Qt::Alignment alignment);
  void setTextAlignment(Qt::Alignment alignment);
  void setRotation(double degrees);
  void setPadding(const QMargins &padding);
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  
  QCPItemPosition * position /NoSetter/;
  QCPItemAnchor * topLeft /NoSetter/;
  QCPItemAnchor * top /NoSetter/;
  QCPItemAnchor * topRight /NoSetter/;
  QCPItemAnchor * right /NoSetter/;
  QCPItemAnchor * bottomRight /NoSetter/;
  QCPItemAnchor * bottom /NoSetter/;
  QCPItemAnchor * bottomLeft /NoSetter/;
  QCPItemAnchor * left /NoSetter/;

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual QPointF anchorPixelPosition(int anchorId) const;

  // non-virtual methods:
  QPointF getTextDrawPoint(const QPointF &pos, const QRectF &rect, Qt::Alignment positionAlignment) const;
  QFont mainFont() const;
  QColor mainColor() const;
  QPen mainPen() const;
  QBrush mainBrush() const;
};
